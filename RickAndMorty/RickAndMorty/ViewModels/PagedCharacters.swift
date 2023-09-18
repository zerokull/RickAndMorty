import SwiftUI
import Combine

/// Model used to manage paged load in CharacterListView
class PagedCharacters: ObservableObject {
    @Published var list = Characters()

    var membersListFull = false
    var currentPage = 1

    private var cancellable: AnyCancellable?

    func fetchMembers() {
        var url: URL?
        if currentPage > 1, let nextPage = list.info.next, let nextPageURL = URL(string: nextPage) {
            url = nextPageURL
        } else if currentPage <= 1, let initialURL = URL(string: APICharacterEndpoint.allCharacters.urlString()){
            url = initialURL
        }

        guard let url = url else {
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ $0.data }
            .decode(type: Characters.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.list) }
            .sink { [weak self] in
                self?.currentPage += 1
                self?.list.info = $0.info
                self?.list.results.append(contentsOf: $0.results)
                if self?.currentPage == $0.info.count {
                    self?.membersListFull = true
                }
            }
    }
}

