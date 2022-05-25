import SwiftUI

struct FlickrPhotosGridView: View {
    @ObservedObject var viewModel: FlickrViewModel

    let columns = [
       GridItem(.adaptive(minimum: 120)),
       GridItem(.adaptive(minimum: 120)),
       GridItem(.adaptive(minimum: 120))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.flickrPhotos,  id: \.id) { item in
                    AsyncImage(url: URL(string: item.url_sq))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct FlickrPhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrPhotosGridView(viewModel: FlickrViewModel())
    }
}
