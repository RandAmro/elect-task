import Foundation
import Combine

class APIServices {
    public static let shared = APIServices()
    let api_key = "83ca7e7a5ce1477cd0ed83d2820145c0"
    let method = "flickr.photos.search"
    var flickrURLString: String = "http://www.flickr.com"
    var subscription: Set<AnyCancellable> = []
    private static let sessionQueue = DispatchQueue(label: "SessionQueue")
    
    func fetch(searchText: String, completion: @escaping ((Result<FlickrPhotos, Error>) -> Void)) {
        flickrURLString = "https://www.flickr.com/services/rest/?method=\(self.method)&api_key=\(self.api_key)&tags=\(searchText)&extras=url_sq,url_n&per_page=21&page=1&format=json&nojsoncallback=1&media=photos"
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
        .sink(receiveCompletion: {_ in }, receiveValue: { (flickrObject) in
            completion(.success(flickrObject.photos))
        }).store(in: &subscription)
    }
}
