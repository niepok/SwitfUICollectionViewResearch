//
//  NetworkingManager.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 13/04/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager: ObservableObject {
    var pokemonAPIList = PokemonAPIList(results: [])
    private let userDefaults = UserDefaults.standard
    private let defaultsKey = "pokes"

    var pokemons: [Pokemon] = [] {
        didSet {
            savePoks()
        }
    }

    @Published var poks: [PokemonImage] = []

    init() {
        let poks = getPoks()
        if poks.isEmpty {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }

            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }

                let pokemonList = try! JSONDecoder().decode(PokemonAPIList.self, from: data)

                DispatchQueue.main.async {
                    self.pokemonAPIList = pokemonList
                    self.getPokemonList()
                }
            }.resume()
        } else {
            pokemons.append(contentsOf: poks)
            if pokemons.count == 151 {
                pokemons.forEach {
                    getImage(for: $0)
                }
            }
        }
    }

    private func getPokemonList() {
        pokemonAPIList.results.forEach {
            guard let url = URL(string: $0.url) else { return }

            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }

                let pokemon = try! JSONDecoder().decode(Pokemon.self, from: data)

                DispatchQueue.main.async {
                    self.pokemons.append(pokemon)
                }
            }.resume()
        }
    }

    private func getImage(for pok: Pokemon) {
        if let img = retrieveImage(forKey: pok.name) {
            self.poks.append(PokemonImage(pokemon: pok, image: img))
        } else {
            guard let url = URL(string: pok.sprites.frontDefault) else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }

                var img: UIImage
                if let image = UIImage(data: data) {
                    img = image
                    self.save(image: img, forKey: pok.name)
                } else {
                    img = UIImage(named: "pika")!
                }

                DispatchQueue.main.async {
                    self.poks.append(PokemonImage(pokemon: pok, image: img))
                    print("🖼 \(pok.name)")
                }
            }.resume()
        }
    }
}

extension NetworkingManager {
    private func getPoks() -> [Pokemon] {
        guard let savedData = UserDefaults.standard.data(forKey: defaultsKey) else { return [] }
        let decoder = JSONDecoder()
        if let poks = try? decoder.decode(Array.self, from: savedData) as [Pokemon] {
            return poks
        }
        return []
    }

    private func savePoks() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(pokemons)
            UserDefaults.standard.set(data, forKey: defaultsKey)
        } catch {
            print("error encoding")
        }
    }
}

enum StorageType {
    case userDefaults
    case fileSystem
}

extension NetworkingManager {
    private func save(image: UIImage, forKey key: String) {
        store(image: image, forKey: key, withStorageType: .fileSystem)
        store(image: image, forKey: key, withStorageType: .userDefaults)
    }

    private func store(image: UIImage,
                       forKey key: String,
                       withStorageType storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do  {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation,
                                          forKey: key)
            }
        }
    }

    private func retrieveImage(forKey key: String) -> UIImage? {
        guard let img = retrieveImage(forKey: key, inStorageType: .fileSystem) else {
            guard let imgg = retrieveImage(forKey: key, inStorageType: .userDefaults) else {
                return nil
            }
            return imgg
        }
        return img
    }

    private func retrieveImage(forKey key: String,
                               inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }

        return nil
    }

    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }

        return documentURL.appendingPathComponent(key + ".png")
    }
}
