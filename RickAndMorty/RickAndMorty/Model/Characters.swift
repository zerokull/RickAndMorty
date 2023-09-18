//

import SwiftUI
import Combine

/// Core model
struct Characters: Codable {
    struct Info: Codable {
        var count: Int
        var pages: Int = 1
        var next: String?
        var prev: String?
    }

    var info: Info = Info(count: 0)
    var results: [Character] = []
}
