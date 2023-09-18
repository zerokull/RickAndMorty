//

import SwiftUI

/// A single location, related to a character
struct Location: Identifiable, Codable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
}
