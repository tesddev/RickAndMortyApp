# Rick and Morty App

A two-screen iOS application that allows users to browse and view details of characters from the Rick and Morty universe. The app demonstrates SwiftUI, UIKit bridging, modular architecture, and testing.

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/d3018f8a-4b70-47ee-873e-7abf614d542f" width="300" height="600"></td>
    <td><img src="https://github.com/user-attachments/assets/8629d45c-3bee-43e0-b59a-39b7adb3ac0d" width="300" height="600"></td>
  </tr>
</table>

## Features

- Browse Rick and Morty characters
- View detailed information about each character
- Smooth UIKit integration with SwiftUI
- Clean architecture with MVVM pattern
- Swift Package Manager module for networking and data models
- Comprehensive unit tests with 100% coverage for the logic layer
- CI integration with GitHub Actions

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
