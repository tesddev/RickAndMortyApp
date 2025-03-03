# Rick and Morty App

A SwiftUI application that displays information about Rick and Morty characters using the Rick and Morty API.

## Features

- Browse Rick and Morty characters
- View detailed information about each character
- Smooth UIKit integration with SwiftUI
- Clean architecture with MVVM pattern

## Requirements

- iOS 17.4+
- Xcode 15.3+
- Swift 5.0+

## Dependencies

- CharacterKit
  - Swift Package from https://github.com/tesddev/CharacterKitPackage

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/tesddev/RickAndMortyApp.git
   ```

2. Open the project in Xcode:
   ```bash
   cd RickAndMortyApp
   open RickAndMortyApp.xcodeproj
   ```

3. Xcode will automatically resolve the package dependencies

4. Build and run the project (⌘+R)

## Project Structure

```
RickAndMortyApp/
├── Views/
│   ├── CharacterListView.swift
│   └── CharacterDetailView.swift
├── ViewModels/
│   └── CharacterListViewModel.swift
└── UIKit/
    ├── CharacterCardView.swift
    └── CharacterCardViewRepresentable.swift
```

## Testing

Run the tests using:
- Xcode's Test Navigator (⌘+6)
- Or use the command line:
  ```bash
  xcodebuild test -scheme RickAndMortyApp -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 15'
  ```

## License

This project is licensed under the MIT License - see the LICENSE file for details
