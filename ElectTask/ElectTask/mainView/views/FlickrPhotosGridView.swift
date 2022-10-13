import SwiftUI

struct FlickrPhotosGridView: View {
    @ObservedObject var viewModel: FlickrViewModel
    @State var presented: Bool = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 32) {
                ForEach(viewModel.flickrPhotos,  id: \.id) { item in
                    AsyncImage(
                        url: URL(string: item.url_sq),
                        content: { image in
                           image.resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                           ProgressView()
                        }
                    )
                    .cornerRadius(8)
                    .gesture(TapGesture()
                        .onEnded {
                            viewModel.selectedPhoto = item.url_n
                            presented.toggle()
                        }
                    )
                }
                .padding(.horizontal, 8)
            }
            .padding(16)
        }
        .sheet(isPresented: $presented){
            FlickrPhotoView(viewModel: viewModel, snapshot: UIImage())
        }
    }
}

struct FlickrPhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrPhotosGridView(viewModel: FlickrViewModel())
    }
}
