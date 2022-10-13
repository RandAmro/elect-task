import SwiftUI

struct FlickrObject: Codable {
    let photos: FlickrPhotos
}

struct FlickrPhotos: Codable {
    let page: Int
    let pages: Int
    let total: Double
    let photo: [photos]
}

struct photos: Codable {
    let id: String
    let title: String
    let url_sq: String
    let url_n: String
}
