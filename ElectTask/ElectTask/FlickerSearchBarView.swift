import SwiftUI

struct FlickerSearchBarView: View {
    @Binding var searchText: String
    @Binding var searching: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
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
        FlickerSearchBarView(searchText: .constant("Electrolux"), searching: .constant(false))
    }
}
