//
//  CharacterCardViewRepresentable.swift
//  RickAndMortyApp
//
//  Created by Tes on 01/03/2025.
//

import Foundation
import SwiftUI
import CharacterKit

// MARK: - SwiftUI Bridge for UIKit Component
struct CharacterCardViewRepresentable: UIViewRepresentable {
    let character: Character
    
    func makeUIView(context: Context) -> CharacterCardView {
        let view = CharacterCardView()
        return view
    }
    
    func updateUIView(_ uiView: CharacterCardView, context: Context) {
        uiView.configure(with: character)
    }
}

// Preview providers for SwiftUI views
#if DEBUG
struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailView(
                character: Character(
                    id: 1,
                    name: "Rick Sanchez",
                    status: "Alive",
                    species: "Human",
                    type: "",
                    gender: "Male",
                    origin: Location(name: "Earth", url: ""),
                    location: Location(name: "Earth", url: ""),
                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    episode: ["https://rickandmortyapi.com/api/episode/1"],
                    url: "",
                    created: ""
                )
            )
        }
    }
}
#endif
