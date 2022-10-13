import SwiftUI

struct FlickrPhotoView: View {
    @ObservedObject var viewModel: FlickrViewModel
    @State var snapshot: UIImage

    var body: some View {
        VStack {
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

            Button(action: {
                UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil)
            }) {
                Text("Save to image")
                    .foregroundColor(.blue)
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.blue, lineWidth: 2)
                    )
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
