import SwiftUI

@main
struct ElectTaskApp: App {
    @ObservedObject var viewModel = FlickrViewModel()

    var body: some Scene {
        WindowGroup {
            FlickrMainView(viewModel: viewModel)
        }
    }
}
