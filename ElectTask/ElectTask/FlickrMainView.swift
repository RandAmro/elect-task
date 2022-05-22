import SwiftUI

struct FlickrMainView: View {
    @State var searchText = "Electrolux"
    @State var searching = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                FlickerSearchBarView(searchText: $searchText, searching: $searching)
                FlickrPhotosGridView()
                .navigationTitle("Flickrs Photos")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                if searching {
                    Button("Cancel") {
                        searchText = ""
                        withAnimation {
                           searching = false
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
        FlickrMainView()
    }
}
