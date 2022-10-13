import SwiftUI

struct FlickrMainView: View {
    @ObservedObject var viewModel: FlickrViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                FlickerSearchBarView(viewModel: viewModel)
                FlickrPhotosGridView(viewModel: viewModel)
                .navigationTitle("Flickrs Photos")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                if viewModel.searching {
                    Button("Cancel") {
                        viewModel.searchText = ""
                        withAnimation {
                            viewModel.searching = false
                           UIApplication.shared.dismissKeyboard()
                        }
                    }
                }
            }
            .gesture(DragGesture()
                        .onChanged({ _ in
                UIApplication.shared.dismissKeyboard()
                        })
            )
        }
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct FlickrMainView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrMainView(viewModel: FlickrViewModel())
    }
}
