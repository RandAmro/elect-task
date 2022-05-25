import Foundation
import Combine

class FlickrViewModel: ObservableObject {

    @Published var searchText: String = "Electrolux"
    @Published var searching = false
    @Published var flickrPhotos: [photos] = []
    @Published var selectedPhoto: String = String()

    var subscription: Set<AnyCancellable> = []

    let api_key = "83ca7e7a5ce1477cd0ed83d2820145c0"
    let method = "flickr.photos.search"
    var flickrURLString: String = "http://www.flickr.com"

    private static let sessionQueue = DispatchQueue(label: "SessionQueue")

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
            fetch()
        }.store(in: &subscription)
    }

    private func fetch() {
        print("maybe search change")
        print(searchText)
        flickrURLString = "https://www.flickr.com/services/rest/?method=\(self.method)&api_key=\(self.api_key)&tags=\(self.searchText)&extras=url_sq,url_n&per_page=21&page=1&format=json&nojsoncallback=1&media=photos"
        guard let url = URL(string: flickrURLString) else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
        .subscribe(on: Self.sessionQueue)
        .map({
            return $0.data
        })
        .decode(type: FlickrObject.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { (suscriberCompletion) in
            switch suscriberCompletion {
            case .finished:
              // TODO: BACK TO THIS LATER
              break
            case .failure(let error):
              print(error)
            }
        }, receiveValue: { [weak self] (flickrObject) in
            self?.flickrPhotos = flickrObject.photos.photo
        }).store(in: &subscription)
    }

}
