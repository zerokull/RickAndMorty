//

import SwiftUI

typealias LocationResponse = (Location?) -> Void

/// Options to be used in App load
enum APILocationEndpoint {
    case location(Int)

    func urlString() -> String {
        switch self {
        case .location(let locationID):
            return "https://rickandmortyapi.com/api/location/\(locationID)"
        }
    }
}

// MARK: - Public methods

/// Generic method to retrieve a specific location
/// - Parameters:
///   - endpoint: a supported endpoint
///   - completion: block where if be returned the model parsed
func getLocation(_ endpoint: APILocationEndpoint, completion: @escaping LocationResponse) {
    switch endpoint {
    case .location(_):
        getLocation(endpoint.urlString(), completion: completion)
    }
}

func getLocation(_ url: String, completion: @escaping LocationResponse) {
    performRequest(url) { locationData in
        parseLocationJSON(locationData) { location in
            DispatchQueue.main.async {
                completion(location)
            }
        }
    }
}

// MARK: - Aux methods

private func parseLocationJSON(_ data: Data?, completion: LocationResponse) {
    guard let data = data else {
        completion(nil)
        return
    }

    let location = try? JSONDecoder().decode(Location.self, from: data)
    completion(location)
}
