import SwiftUI

struct FlickrPhotoView: View {
    @ObservedObject var viewModel: FlickrViewModel
    @State var snapshot: UIImage

    var body: some View {
        VStack {
            Text(viewModel.selectedPhoto)

            AsyncImage(url: URL(string: viewModel.selectedPhoto)) { phase in
                switch phase {
                case .empty:
                    Color.purple.opacity(0.1)
                case .success(let image):
                    image
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                    let _ = DispatchQueue.main.async {
                        snapshot = image.snapshot()
                    }
                case .failure(_):
                    Color.red.opacity(0.1)
                @unknown default:
                    Color.red.opacity(0.1)
                   // add some default picture
                }
            }
            .frame(width: 300, height: 300)
            .cornerRadius(20)

            Button("Save to image") {
                UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil)
            }
        }
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
