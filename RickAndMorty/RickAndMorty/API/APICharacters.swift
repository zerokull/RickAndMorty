//

import SwiftUI

typealias CharacterListResponse = (Characters?) -> Void
typealias RequestResponse = (Data?) -> Void

/// Options to be used in App load to filter
enum APICharacterEndpoint {
    case character(Int)
    case allCharacters
    case characterFilter(String)
    case characterList(Int)

    enum APICharacterFilter {
        case name, status, species, gender
    }

    func urlString() -> String {
        switch self {

        case .character(let characterId):
            return "https://rickandmortyapi.com/api/character/\(characterId)"
        case .allCharacters:
            return "https://rickandmortyapi.com/api/character"
        case .characterFilter(let filter):
            return "https://rickandmortyapi.com/api/character/?\(filter)"
        case .characterList(let count):
            var idsArray = [Int]()
            for i in 1...count {
                idsArray.append(i)
            }
            let ids = idsArray.map{ String($0) }.joined(separator: ",")
            return "https://rickandmortyapi.com/api/character/\(ids)"
        }
    }
}

// MARK: - Public methods

/// Generic method to retrieve a specific character list
/// - Parameters:
///   - endpoint: a supported endpoint
///   - completion: block where if be returned the model parsed
func getCharacter(_ endpoint: APICharacterEndpoint, completion: @escaping CharacterListResponse) {
    switch endpoint {

    case .character(_):
        getCharacter(endpoint.urlString(), completion: completion)
    case .allCharacters:
        getAllCharacters(endpoint.urlString(), completion: completion)
    case .characterFilter(_):
        getFilteredCharacters(endpoint.urlString(), completion: completion)
    case .characterList(_):
        getCharacterList(endpoint.urlString(), completion: completion)
    }
}



func getNextPrevCharacterPage(_ url: String, completion: @escaping CharacterListResponse) {
    getAllCharacters(url, completion: completion)
}

func getCharacter(_ url: String, completion: @escaping CharacterListResponse) {
    performRequest(url) { characterData in
        parseCharacterJSON(characterData) { character in
            DispatchQueue.main.async {
                completion(character)
            }
        }
    }
}

func getAllCharacters(_ url: String, completion: @escaping CharacterListResponse) {
    performRequest(url) { charactersData in
        parseAllCharactersJSON(charactersData) { characters in
            DispatchQueue.main.async {
                completion(characters)
            }
        }
    }
}

func getCharacterList(_ url: String, completion: @escaping CharacterListResponse) {
    performRequest(url) { charactersData in
        parseCharactersJSON(charactersData) { characters in
            DispatchQueue.main.async {
                completion(characters)
            }
        }
    }
}

func getFilteredCharacters(_ url: String, completion: @escaping CharacterListResponse) {
    getAllCharacters(url, completion: completion)
}

// MARK: - Aux methods

func parseCharactersJSON(_ data: Data?, completion: CharacterListResponse) {
    guard let data = data else {
        completion(nil)
        return
    }

    let chars = try? JSONDecoder().decode([Character].self, from: data)

    let info = Characters.Info(count: chars?.count ?? 0)
    let characters = Characters(info: info,
                                results: chars ?? [])
    completion(characters)
}

private func parseAllCharactersJSON(_ data: Data?, completion: CharacterListResponse) {
    guard let data = data else {
        completion(nil)
        return
    }

    let characters = try? JSONDecoder().decode(Characters.self, from: data)
    completion(characters)
}

private func parseCharacterJSON(_ data: Data?, completion: CharacterListResponse) {
    guard let data = data else {
        completion(nil)
        return
    }

    let character = try? JSONDecoder().decode(Character.self, from: data)
    var charsArray = [Character]()

    if let character = character  {
        charsArray.append(character)
    }

    let info = Characters.Info(count: charsArray.count)
    let characters = Characters(info: info,
                                results: charsArray)

    completion(characters)
}
