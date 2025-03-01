//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Tes on 01/03/2025.
//

import SwiftUI
import CharacterKit

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Hero image
                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Status indicator
                    HStack {
                        Circle()
                            .fill(statusColor)
                            .frame(width: 10, height: 10)
                        Text("\(character.status) - \(character.species)")
                            .font(.headline)
                    }
                    
                    // Info sections
                    infoSection(title: "Gender", value: character.gender)
                    
                    infoSection(title: "Origin", value: character.origin.name)
                    
                    infoSection(title: "Last known location", value: character.location.name)
                    
                    if !character.type.isEmpty {
                        infoSection(title: "Type", value: character.type)
                    }
                    
                    // Episodes section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Episodes")
                            .font(.headline)
                        
                        Text("Appeared in \(character.episode.count) episode(s)")
                            .font(.body)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var statusColor: Color {
        switch character.status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
    
    private func infoSection(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            Text(value)
                .font(.body)
        }
    }
}
