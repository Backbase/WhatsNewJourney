require 'yaml'

def update_versions(version, journey)
  Dir.chdir('..') do
    # Replace version in .env file
    sh "sed -i '' -E 's/^TARGET_VERSION=\"[0-9]+(\.[0-9]+)*\"/TARGET_VERSION=\"#{version}\"/g' .env.#{journey}"
    # Replace version in project.yml. The 'sed' command was not playing nice with the whitespace in the yaml file.
    contents = sh "awk '{gsub(/MARKETING_VERSION:.*/,\"MARKETING_VERSION: #{version}\")} 1' project.yml"
    File.open('project.yml', 'w') { |f| f.write(contents) }
  end
  
  with_env(journey) do
    version_bump_podspec(version_number: version)
  end
end

def package_xcframework(options = {})
  deploy_directory = ''
  build_directory = ''

  product_name = options[:scheme]
  framework = product_name + '.xcframework'
  podspec = product_name + '.podspec'
  zip_name = "#{product_name.underscore.dasherize}-ios"
  sym_dsym = ''
  device_dsym = ''

  zipped_product = zip_name + '-' + options[:version].to_s + '.tar.gz'
  
  Dir.chdir('..') do
    deploy_directory = File.join(Dir.pwd, '.deploy')
    build_directory = File.join(Dir.pwd, options[:build_directory])
    
    xcframework_dir = File.join(build_directory, 'Products', 'XCFramework')
    archive_dir = File.join(build_directory, 'Products', 'Archive')
    sim_dsym_dir = File.join(archive_dir, "#{product_name}_sim.xcarchive", 'dSYMs')
    device_dsym_dir = File.join(archive_dir, "#{product_name}_device.xcarchive", 'dSYMs')
    
    sym_dsym = product_name + '_sim.framework.dSYM'
    device_dsym = product_name + '_device.framework.dSYM'

    FileUtils.mkdir_p deploy_directory

    FileUtils.cp_r(podspec, deploy_directory)
    FileUtils.cp_r(File.join(xcframework_dir, framework), deploy_directory)
    FileUtils.cp_r(File.join(sim_dsym_dir, "#{product_name}.framework.dSYM"), File.join(deploy_directory, sym_dsym))
    FileUtils.cp_r(File.join(device_dsym_dir, "#{product_name}.framework.dSYM"), File.join(deploy_directory, device_dsym))
  end

  Dir.chdir(deploy_directory) do
    sh "tar cfvz \"#{zipped_product}\" #{framework} #{podspec} #{sym_dsym} #{device_dsym}"
  end

  [deploy_directory, zipped_product]
end

# Looks for a .env file for the given target in the project root folder.
# @param target [String] The name of the target to get the .env file path for
# @return [String] The path for the .env file
def dotenv_path(target)
  filename = ".env.#{target}"
  project_dir = File.expand_path('..', Dir.pwd)
  File.join(project_dir, filename)
end

# Runs the given block for each target, after loading the associated .env 
# file. If the file is not found, the block is not executed for that target.
# @param targets [String] Comma separated list of targets
# @param block [Proc] The block to run for each valid target
def with_env(targets, &block)
  targets
    .split(',')
    .map { |target| dotenv_path(target) }
    .filter { |filename| File.exist? filename }
    .each do |file|
      Dotenv.overload file
      yield block if block_given?
    end
end

# Updates a post build script or adds it if it doesn't exist
# @param scheme [String] The name of scheme whose post build scripts will be updated,
def updatePostBuildScript(scheme)
  # The path of the project's YAML file (Relative to the project's directory)
  projectFile = "project.yml"
  # The name of the post build script to be updated
  oldScriptName = "Copy Swiftinterface file"
  # The new name of the updated post build script
  newScriptName = "Copy Swiftinterface file"
  # The script that the old script will be replaced with
  newPostBuildScript = {
    "name" => newScriptName,
    "script" => <<-SCRIPT
#!/bin/sh -e
SWIFTINTERFACE_PATH="${BUILT_PRODUCTS_DIR}/${TARGETNAME}.framework/Modules/${TARGETNAME}.swiftmodule/*.swiftinterface"
mkdir -p ${PROJECT_DIR}/api/#{scheme}
cp ${SWIFTINTERFACE_PATH} ${PROJECT_DIR}/api/#{scheme}
sed -i '' "s/\\/\\/ swift-compiler-version:.*/\\/\\/ swift-compiler-version: REMOVED/g" api/#{scheme}/*.swiftinterface
SCRIPT
  }

  puts "Updating the post build scripts of #{scheme}"

  yml = Dir.chdir('..') { YAML.load_file projectFile }

  # If postBuildScripts section doesn't exist add it.
  if yml["targets"][scheme]["postBuildScripts"] == nil
    yml["targets"][scheme]["postBuildScripts"] = []
  end

  hasFound = false
  postBuildScripts = yml["targets"][scheme]["postBuildScripts"]
  
  # Find the post build script
  postBuildScripts.each do |postBuildScript|
    if postBuildScript["name"] == oldScriptName
      hasFound = true
      postBuildScript["name"] = newPostBuildScript["name"]
      postBuildScript["script"] = newPostBuildScript["script"]
    end
  end

  # Update the script if it already exists, otherwise add it.
  if hasFound
    yml["targets"][scheme]["postBuildScripts"] = postBuildScripts
  else
    yml["targets"][scheme]["postBuildScripts"].append(newPostBuildScript)
  end

  puts "Saving the post build scripts of #{scheme}"

  Dir.chdir('..') {
    File.open(projectFile, 'w') { |f| YAML.dump(yml, f, indentation: 2) }
  }

  puts "Finished updating the post build scripts of #{scheme}"
end
