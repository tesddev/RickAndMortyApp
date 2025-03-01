//
//  CharacterCardView.swift
//  RickAndMortyApp
//
//  Created by Tes on 01/03/2025.
//

import Foundation
import UIKit
import CharacterKit

// MARK: - UIKit Component
class CharacterCardView: UIView {
    // MARK: - Properties
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let statusIndicator = UIView()
    private let stackView = UIStackView()
    
    private var character: Character?
    private var imageTask: URLSessionDataTask?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Configuration
    func configure(with character: Character) {
        self.character = character
        
        nameLabel.text = character.name
        statusLabel.text = "\(character.status) - \(character.species)"
        
        // Configure status indicator color
        switch character.status.lowercased() {
        case "alive":
            statusIndicator.backgroundColor = .systemGreen
        case "dead":
            statusIndicator.backgroundColor = .systemRed
        default:
            statusIndicator.backgroundColor = .systemGray
        }
        
        // Cancel any previous image loading
        imageTask?.cancel()
        characterImageView.image = nil // Reset image before loading a new one
        
        // Load image asynchronously
        if let url = URL(string: character.image) {
            loadImage(from: url)
        }
    }
    
    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        clipsToBounds = false
        
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 1
        
        statusIndicator.translatesAutoresizingMaskIntoConstraints = false
        statusIndicator.layer.cornerRadius = 5
        
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .secondaryLabel
        
        let infoStack = UIStackView(arrangedSubviews: [statusIndicator, statusLabel])
        infoStack.spacing = 8
        infoStack.alignment = .center
        
        let textStack = UIStackView(arrangedSubviews: [nameLabel, infoStack])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.distribution = .fill
        textStack.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textStack.isLayoutMarginsRelativeArrangement = true
        
        addSubview(characterImageView)
        addSubview(textStack)
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            statusIndicator.widthAnchor.constraint(equalToConstant: 10),
            statusIndicator.heightAnchor.constraint(equalToConstant: 10),
        ])
        
        textStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            textStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            textStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Image Loading
    private func loadImage(from url: URL) {
        imageTask?.cancel()
        
        characterImageView.image = nil // Reset image
        
        imageTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.characterImageView.image = image
            }
        }
        
        imageTask?.resume()
    }
}
