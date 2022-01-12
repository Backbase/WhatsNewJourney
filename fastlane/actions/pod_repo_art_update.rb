module Fastlane
    module Actions
      module SharedValues
      end
  
      class PodRepoArtUpdateAction < Action
        def self.run(params)
          UI.message 'Checking for available repos...'
          all_repos = sh 'pod repo-art | egrep \'^[a-zA-Z]\''
          repos = params[:repos] || all_repos.split("\n")
          repos.each do |repo| 
            UI.message "Updating #{repo}..."
            sh "pod repo-art update #{repo}"
          end
        end
  
        #####################################################
        # @!group Documentation
        #####################################################
  
        def self.description
          'You can use this command to update your repo-art repositories'
        end
  
        def self.details
          ''
        end
  
        def self.available_options
          [
            FastlaneCore::ConfigItem.new(
              key: :repos,
              env_name: 'PRAU_REPOS',
              description: 'Array of repos to update',
              optional: true,
              is_string: false,
              verify_block: proc do |value|
                UI.user_error!(':repos should be an array') unless (value.kind_of?(Array))
              end
            )
          ]
        end
  
        def self.output
          []
        end
  
        def self.return_value
          nil
        end
  
        def self.authors
          ["Your GitHub/Twitter Name"]
        end
  
        def self.is_supported?(platform)
          [:ios, :mac].include?(platform)
        end
      end
    end
  end
  