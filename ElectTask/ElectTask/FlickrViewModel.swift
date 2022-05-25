import Foundation
import SwiftUI
import Combine

class FlickrViewModel: ObservableObject {

    @Published var searchText: String = "Electrolux"
    @Published var searching = false
    @Published var flickrPhotos: [photos] = []

    let api_key = "83ca7e7a5ce1477cd0ed83d2820145c0"
    let method = "flickr.photos.search"
    var flickrURLString: String = "http://www.flickr.com"

    private let session: URLSession
    private var cancelable: AnyCancellable?
    private static let sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")

    init(session: URLSession = .shared) {
        self.session = session

        flickrURLString = "https://www.flickr.com/services/rest/?method=\(self.method)&api_key=\(self.api_key)&tags=\(self.searchText)&extras=url_sq&per_page=21&page=1&format=json&nojsoncallback=1"
        fetch()
    }

    private func fetch() {
        guard let url = URL(string: flickrURLString) else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
        .subscribe(on: Self.sessionProcessingQueue)
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
            self?.flickrPhotos.append(contentsOf: flickrObject.photos.photo)
        })
    }

}
