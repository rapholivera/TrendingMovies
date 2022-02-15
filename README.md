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
git clone https://github.com/rapholivera/lista-filmes.git
```

## Dependency injection 💉

Note: Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)

![Header](README-FILES/CleanArchitectureDependencies.png)

## Libraries used in this project

* [SwiftLint](https://github.com/realm/SwiftLint)
* [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)

