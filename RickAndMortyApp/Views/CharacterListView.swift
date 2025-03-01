//
//  CharacterListView.swift
//  RickAndMortyApp
//
//  Created by Tes on 01/03/2025.
//

import Foundation
import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle())
                } else if !viewModel.errorMessage.isEmpty {
                    VStack(spacing: 16) {
                        Text("Error")
                            .font(.title)
                            .foregroundColor(.red)
                        Text(viewModel.errorMessage)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button(action: viewModel.fetchCharacters) {
                            Text("Try Again")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                CharacterCardViewRepresentable(character: character)
                                    .frame(height: 200)
                                    .listRowInsets(EdgeInsets())
                                    .listRowBackground(Color.clear)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Rick and Morty")
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }
}
