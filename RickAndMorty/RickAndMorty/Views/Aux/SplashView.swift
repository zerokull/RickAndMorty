//

import SwiftUI

/// Initial view while we are loading all data
struct SplashView: View {
    @EnvironmentObject var dto: CharactersDTO
    @State private var navigate = false
    let destinationView = CharacterListView()
    
    // MARK: añadida navegacion
    var body: some View {
        /// Accessibility remove image from acc navigation it's just decorative
        VStack {
            image
            text
            navigation
        }
        .onAppear() {
            getCharacter(.allCharacters) { characters in
                if let characters = characters {
                    self.dto.characters = characters
                    self.navigate = true
                } else {
                    print("¡error loading characters list view!")
                }
            }
        }
    }
    
    var image: some View {
        Image("rick_morty2", bundle: .main)
            .resizable()
            .scaledToFit()
    }
    
    var text: some View {
        HStack {
            Text("Rick and morty app is loading... ")
            ProgressView()
        }
    }
    
    var navigation: some View {
        NavigationLink(isActive: $navigate) {
            destinationView
                .navigationBarBackButtonHidden(true)
        } label: {
            EmptyView()
        }
    }
}

struct InitialLoadingView_Previews: PreviewProvider {
    static let dto = CharactersDTO()
    static var previews: some View {
        SplashView()
            .environmentObject(dto)
    }
}
