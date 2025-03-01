//
//  CharacterListViewModelTests.swift
//  RickAndMortyAppTests
//
//  Created by Tes on 01/03/2025.
//

import Foundation
import XCTest
import CharacterKit
@testable import RickAndMortyApp

// Mock CharacterRepository for testing
class MockCharacterRepository: CharacterRepositoryProtocol {
    var shouldSucceed = true
    var characters: [Character] = []
    var error: Error = NSError(domain: "com.test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
    
    var fetchCharactersCalled = false
    var fetchCharacterByIdCalled = false
    var idRequested: Int?
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        fetchCharactersCalled = true
        
        if shouldSucceed {
            completion(.success(characters))
        } else {
            completion(.failure(error))
        }
    }
    
    func fetchCharacter(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        fetchCharacterByIdCalled = true
        idRequested = id
        
        if shouldSucceed, let character = characters.first(where: { $0.id == id }) {
            completion(.success(character))
        } else {
            completion(.failure(error))
        }
    }
}

final class CharacterListViewModelTests: XCTestCase {
    var mockRepository: MockCharacterRepository!
    var viewModel: CharacterListViewModel!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCharacterRepository()
        viewModel = CharacterListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchCharactersSuccess() {
        // Given
        let location = Location(name: "Earth", url: "https://example.com/locations/1")
        let character = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: location,
            location: location,
            image: "https://example.com/characters/1.jpg",
            episode: ["https://example.com/episodes/1"],
            url: "https://example.com/characters/1",
            created: "2021-01-01"
        )
        
        mockRepository.characters = [character]
        mockRepository.shouldSucceed = true
        
        let expectation = XCTestExpectation(description: "Fetch characters success")
        
        // When
        viewModel.fetchCharacters()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockRepository.fetchCharactersCalled)
            XCTAssertEqual(self.viewModel.characters.count, 1)
            XCTAssertEqual(self.viewModel.characters.first?.id, 1)
            XCTAssertEqual(self.viewModel.characters.first?.name, "Rick Sanchez")
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.errorMessage.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCharactersFailure() {
        // Given
        mockRepository.shouldSucceed = false
        
        let expectation = XCTestExpectation(description: "Fetch characters failure")
        
        // When
        viewModel.fetchCharacters()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockRepository.fetchCharactersCalled)
            XCTAssertTrue(self.viewModel.characters.isEmpty)
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertFalse(self.viewModel.errorMessage.isEmpty)
            XCTAssertEqual(self.viewModel.errorMessage, "Test error")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadingState() {
        // When
        viewModel.fetchCharacters()
        
        // Then
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }
}
