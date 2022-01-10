# What's New Journey (iOS)

This repository contains the components and documentation of the iOS Version of the `What's New Journey`.

## Description
A “What’s New” journey lets you welcome new users and reconnect with returning ones. An optional “What’s new” experience that’s fast, fun, and educational can help people get the most from your app without getting in their way.


## Objective
Create a remotely customizable “What’s New” experience.

The “What’s New” experience should support up to 4 topics. A topic should consist of a title, a description and a logo. The “What’s New” experience should also have a header and a primary button.

## Table of Contents

- [Environment Setup](#environment-setup)
- [Project Generation](#project-generation)
- [Troubleshooting](#troubleshooting)
- [License](#license)


### Environment Setup

> Follow steps in this section if you are setting up the project for the first time, otherwise, skip to the next [section](#project-generation).

Before building the project make sure all above requirements are installed on your device.

#### 1. Install [Homebrew](https://brew.sh/)

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#### 2. Install [Bundler](https://bundler.io/)

```sh
gem install bundler
```

#### 3. Set artifactory credentials

repo-art uses authentication as specified in your standard [netrc](https://www.gnu.org/software/inetutils/manual/html_node/The-_002enetrc-file.html) file.

Log in to Artifacts and click on your name in the top right. Enter your password again and click "Unlock". Next to the "Encrypted Password" field, copy your encrypted password by clicking the "Copy encrypted password to clipboard" button.

Open **~/.netrc** on your computer. If this file does not exist, create it.
Add the following 3 lines to the file, replacing `{username}` with your artifactory username and `{encrypted password}` with the encrypted password you just copied.

```txt
machine repo.backbase.com
  login {username}
  password {encrypted password}
```

#### 4. Install build dependencies

> Within the project directory:

```sh
bundle install
```

#### 5. Add required artifactory repositories

```sh
bundle exec pod repo-art add bbartifacts3 https://repo.backbase.com/api/pods/ios3
bundle exec pod repo-art add bbartifacts-retail3 https://repo.backbase.com/api/pods/ios-retail3
bundle exec pod repo-art add bbartifacts-notifications https://repo.backbase.com/api/pods/ios-mobile-notifications
bundle exec pod repo-art add bbartifacts-identity https://repo.backbase.com/api/pods/ios-identity
```

#### 6. Update artifactory repositories

```sh
bundle exec pod repo-art update bbartifacts3
bundle exec pod repo-art update bbartifacts-retail3
bundle exec pod repo-art add bbartifacts-notifications
bundle exec pod repo-art add bbartifacts-identity
```

> Having a hard time with Ruby? see [troubleshooting](#troubleshooting).

---

### Project Generation

> a.k.a WTH are my .xcodeproj and .xcworkspace files?

To avoid merge conflict and keep the project directory clean; `.xcodeproj` and `.xcworkspace` files are ignored and generated from JSON specs using [XcodeGen](https://github.com/yonaskolb/XcodeGen). Follow the next instructions to generate the Xcode project files:

#### 1. Install build dependencies

```sh
bundle install
```

> Having a hard time with Ruby? see [troubleshooting](#troubleshooting).

#### 2. Generate the project

```sh
bundle exec fastlane prepare

pod install

```

> Having a hard time with Ruby? see [troubleshooting](#troubleshooting).

#### 3. All Set

Voilà, you're all set! open **WhatsNewJourney.xcworkspace** in Xcode.

> **It is important to re-generate the project every time you pull from main.**


## Test App

A Test app is shipped together with this journey. The Test App is a simple iOS app that can be run on either a Simulator or an actual iOS Device. 

To be able to add the WhatsNewJourney as a dependency in the App, please add this line to the Target definition of `WhatsNewTestApp`

`pod 'WhatsNewJourney', :path => '.'`

So this will ensure that any changes on the Journey will be built when the Test app is run/built

## Troubleshooting

### Ruby related problems

Install [rbenv](https://github.com/rbenv/rbenv)

> rbenv is a tool that lets you install and run multiple versions of Ruby side-by-side. It's simple, lightweight, and reliable.

```sh
brew update && brew install rbenv ruby-build
```

Add the following lines to your profile file

> Your profile file is **~/.zshrc** if you are using Z shell, or **~/.bash_profile** if you are using Bash

```bash
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```

> In your project directory, install ruby version required for the project

```sh
rbenv install
```

Then continue the flow in the as in the **Getting Started** section.

---


## License

Backbase License. See [LICENSE](LICENSE) for more info.
