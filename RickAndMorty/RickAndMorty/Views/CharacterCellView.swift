//

import SwiftUI

/// CellView of a character for ChannelListView
struct CharacterCellView: View {
    let character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: character.avatar) { charImage in
                charImage
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(200)
                    .grayscale(1)
                    .contrast(2)
            } placeholder: {
                placeholder
            }
            characterName
        }
    }
    
    var characterName: some View {
        Text(character.name)
            .padding()
            .font(.headline)
            .foregroundColor(.black)
    }
    
    var placeholder: some View {
        VStack(spacing: 10) {
            Image("noImage", bundle: .main)
                .resizable()
                .scaledToFit()
            ProgressView()
            Text("Rick is in progress...")
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character(id: 1,
                                  name: "Rick Sanchez",
                                  species: "human",
                                  avatar: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                  status: "Alive",
                                  gender: "Male")
        CharacterCellView(character: character)
    }
}
