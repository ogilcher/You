import SwiftUI

struct SpellingBeeView: View {
    @StateObject private var viewModel = SpellingBeeViewModel()

    var body: some View {
        VStack {
            Button(
                action: {
                    viewModel.getLink()
                },
                label: {
                    Text("Press me!")
                }
            )
        }
        .onAppear{
            viewModel.getLink()
        }
    }
}

#Preview {
    SpellingBeeView()
}
