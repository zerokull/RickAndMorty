//

import SwiftUI

@main
struct RickAndMortyApp: App {
    @StateObject var dto = CharactersDTO()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SplashView()
                    .environmentObject(dto)
            }
        }
    }
}
