//
//  CharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by Tes on 01/03/2025.
//

import Foundation
import CharacterKit
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
    }
    
    func fetchCharacters() {
        isLoading = true
        errorMessage = ""
        
        repository.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let characters):
                    self.characters = characters
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
