import SwiftUI

struct FlickrPhoto: Decodable, Identifiable {
    var id: Int
    var title: String
    var url_sq: String
    var media: String

    //var photo: CGImage?

    enum CodingKeys: String, CodingKey {
        case id, title, url_sq, media
    }
}
