import Foundation
import Combine

class FlickrViewModel: ObservableObject {

    @Published var searchText: String = "Dogs"
    @Published var searching = false
    @Published var flickrPhotos: [photos] = []
    @Published var selectedPhoto: String = String()

    var subscription: Set<AnyCancellable> = []

    init() {
        $searchText
        .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
        .map({ (string) -> String? in
            if string.count < 1 {
                self.flickrPhotos = []
                return nil
            }
            return string
        })
        .compactMap{ $0 }
        .sink { (_) in
        } receiveValue: { [self] (searchField) in
            APIServices.shared.fetch(searchText: searchText) { (result: Result<FlickrPhotos, Error>) in
                if case let .success(flickrPhotos) = result {
                    self.flickrPhotos = flickrPhotos.photo
                }
            }
        }.store(in: &subscription)
    }
}
