fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### setup

```sh
[bundle exec] fastlane setup
```

Set up the development environment

### setup_projects

```sh
[bundle exec] fastlane setup_projects
```



### pods_update

```sh
[bundle exec] fastlane pods_update
```

Update cocoapods and repo-art automatically if pod install fails

### update_multiple_versions

```sh
[bundle exec] fastlane update_multiple_versions
```

Update versions for multiple journeys

### update_versions

```sh
[bundle exec] fastlane update_versions
```

Update versions for a single journeys

### commit_version_bump_if_needed

```sh
[bundle exec] fastlane commit_version_bump_if_needed
```



### detect_changed_targets

```sh
[bundle exec] fastlane detect_changed_targets
```



### update_api_check

```sh
[bundle exec] fastlane update_api_check
```

Add/Update the API Check post build script of multiple targets

### api_check

```sh
[bundle exec] fastlane api_check
```

Check if the api directory contains any uncommited changes

### test_apps

```sh
[bundle exec] fastlane test_apps
```



### test_journeys

```sh
[bundle exec] fastlane test_journeys
```



### test_targets

```sh
[bundle exec] fastlane test_targets
```



### test

```sh
[bundle exec] fastlane test
```



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
