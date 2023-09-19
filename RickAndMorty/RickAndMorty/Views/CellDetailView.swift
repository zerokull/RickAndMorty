//

import SwiftUI

/// Detailed view of a character
struct CellDetailView: View {
    @State var character: Character
    @State var location: Location? = nil

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    textNameTitle
                    
                    AsyncImage(url: character.avatar) { characterImage in
                        characterImage
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        placeholder
                    }
                    characterDetails
                }
                .padding()
                
                Spacer()
                locationInfo
                Spacer()
                
            }.onAppear {
                getLocation(character.location.url) { location in
                    self.location = location
                }
            }
        }
    }
    
    /// View variables
    var textNameTitle: some View {
        HStack {
            Text(character.name).bold().font(.largeTitle).accessibilityAddTraits(.isHeader)
        }
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
    /// TODO: - create a  accessibility container to have better accLabel semantic and easy navigation
    var characterDetails: some View {
        VStack {
            Text("Character details")
                .bold()
                .font(.title2)
                .frame(alignment: .leading)
                .accessibilityAddTraits(.isHeader)
            
            HStack {
                Text("Gender:").bold()
                Text(character.gender)
            }
            HStack {
                Text("Specie:").bold()
                Text(character.species)
            }
            HStack {
                Text("Status:").bold()
                Text(character.status)
            }
        }
    }
    
    /// TODO: - create a  accessibility container to have better accLabel semantic and easy navigation
    var locationInfo: some View {
        VStack {
            Text("Location information")
                .bold()
                .font(.title2)
                .frame(alignment: .leading)
                .accessibilityAddTraits(.isHeader)
            
            if let location = location {
                HStack {
                    Text("\(location.type):").bold()
                    Text(location.name)
                }
                HStack {
                    Text("Dimension:").bold()
                    Text(location.dimension)
                }
            } else {
                HStack {
                    Text("Loading location info... ")
                    ProgressView()
                }
            }
        }
        .padding()
    }
}

struct CharDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let char = Character(id: 1,
                             name: "Rick Sanchez",
                             species: "human",
                             avatar: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                             status: "Alive",
                             gender: "Male")
        let location = Location(id: 1,
                                name: "Earth",
                                type: "Planet",
                                dimension: "long",
                                residents: [char.name])
        
        CellDetailView(character: char, location: location)
    }
}
