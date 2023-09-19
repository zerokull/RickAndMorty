//

import XCTest
@testable import RickAndMorty

final class RickAndMortyTests: XCTestCase {

    func testRequestingChar1() {
        let expec = expectation(description: "Waiting for character...")

        // Given
        let url = "https://rickandmortyapi.com/api/character/1"

        // When
        getCharacter(url) { characters in
            // Then
            XCTAssertNotNil(characters)
            XCTAssertEqual(characters?.results.count, 1)

            let charName = characters?.results.first?.name ?? ""
            XCTAssertEqual(charName, "Rick Sanchez")

            expec.fulfill()
        }

        wait(for: [expec], timeout: 5)
    }

    func testParseEmptyCharacters() {
        // Given
        let emptyData = Data()

        // When
        parseCharactersJSON(emptyData) { characters in
            // Then
            XCTAssertEqual(characters?.results.count, 0)
        }
    }

    func testParseFakeCharacters() {
        // Given
        let data = Data(charactersJSON.utf8)

        // When
        parseCharactersJSON(data) { characters in
            // Then
            XCTAssertNotNil(characters)
        }
    }

    func testParseFakeCharactersName() {
        // Given
        let page = PagedCharacters()
        let data = Data(charactersJSON.utf8)
        page.list = try! JSONDecoder().decode(Characters.self, from: data)
        page.list.info.count = 2

        // When
        page.fetchMembers()

        // Then
        XCTAssertNotNil(page.list)
        XCTAssertEqual(page.list.results.first?.name, "Rick Sanchez")
    }

}
