# Trending Movies

TrendingMovies demos some UIKit (& Combine) concepts. The goal is to make a application using some good software engineering concepts from my point of view, and show how I like to code. It'll be updated with new features and tests as soon as possible.

## Architecture

TrendingMovies was written in Swift 5 using the TMDb API and demonstrating Clean Architecture, Dependency Injection, MVVM and Coordinators.

## Requirements

* iOS 13.0+
* Xcode 11.0+

## Getting started

You'll need a few things before getting started. Make sure you have the latests Xcode installed from the AppStore or Developer Site. Then you can clone the project with the following command:

```bash
git clone https://github.com/rapholivera/TrendingMovies.git
```

It supports [SwiftLint](https://github.com/realm/SwiftLint), which is the defacto standard for linting Swift files. It is not directly installed as a dependency of the project, but running on mac, if you haven't installed it, the project will run normally. However, if there is any change in the code that doesn't follow the styles defined by swiftlint some of these warnings appear during development in Xcode:

![Header](README-FILES/xcode-swiftlint-warnings.png)

### Instalation using [Homebrew](http://brew.sh/)

```bash
brew install swiftlint
```

## Dependency injection 💉

Note: Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)

![Header](README-FILES/CleanArchitectureDependencies.png)

## Libraries used in this project

* [SwiftLint](https://github.com/realm/SwiftLint)
* [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)

## Roadmap

- [x] Login
- [x] Login - Check user input to enable login button
- [ ] Login - Create a CPF Mask
- [x] Login Tests - Check user input
- [ ] Login Tests - Check callback for user bad credentials
- [ ] Login Tests - Check callback for user good credentials
- [x] Trending
- [x] Trending - List of trending movies
- [ ] Trending - Poster Movies
- [ ] Trending - Search
- [ ] Trending - Open Movie Details
- [ ] Trending Tests - Check success movies response
- [ ] Trending Tests - Check failure movies response
