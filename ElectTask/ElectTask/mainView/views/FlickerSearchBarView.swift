import SwiftUI

struct FlickerSearchBarView: View {
    @ObservedObject var viewModel: FlickrViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $viewModel.searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            viewModel.searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        viewModel.searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, 8)
        }
        .frame(height: 32)
        .cornerRadius(8)
        .padding(8)
    }
}

struct FlickerSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        FlickerSearchBarView(viewModel: FlickrViewModel())
    }
}
