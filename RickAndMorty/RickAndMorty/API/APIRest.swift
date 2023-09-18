//

import Foundation

///  Proccess to perform a request. create a dataTask and execute it
/// - Parameters:
///  - url: valid url to be requested
///  - session: optional session that will manage the request
///  - completion: block where if be returned the raw Data
func performRequest(_ url: String, session: URLSession = URLSession.shared, completion: @escaping RequestResponse) {
    guard let URL = URL(string: url) else {
        completion(nil)
        return
    }

    let request = URLRequest(url: URL)
    let task = session.dataTask(with: request) { data, response, error in
        if error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode < 400, let data = data {
            completion(data)
        } else {
            completion(nil)
        }
    }
    task.resume()
}
