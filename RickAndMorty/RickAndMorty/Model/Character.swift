//

import SwiftUI

/// A single character
struct Character: Identifiable, Codable {
    struct Location: Codable {
        var name: String
        var url: String
    }

    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var location: Location

    var image: String
    var avatar: URL? {
        URL(string: image)
    }

    init(id: Int, name: String = "", species: String = "¿?", avatar: String? = nil, status: String = "unknown", gender: String = "unknown", location: Location? = nil) {
        self.id = id
        self.name = name
        self.species = species
        self.status = status
        self.gender = gender
        self.image = avatar ?? ""
        if let location = location {
            self.location = location
        } else {
            let newLocation = Location(name: "", url: "")
            self.location = newLocation
        }
    }
}
