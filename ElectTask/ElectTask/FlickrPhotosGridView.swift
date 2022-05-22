import SwiftUI

struct FlickrPhotosGridView: View {
    private var flickrPhotos = [FlickrPhoto]()

    let columns = [
       GridItem(.adaptive(minimum: 120)),
       GridItem(.adaptive(minimum: 120)),
       GridItem(.adaptive(minimum: 120))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(flickrPhotos) { item in
                    Image(systemName: "\(item.id).circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct FlickrPhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrPhotosGridView()
    }
}
