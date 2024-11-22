import Foundation
import SwiftUI
import SwiftUICore

struct ContentView: View {
    @StateObject private var viewModel = MemberViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                } else {
                    List(viewModel.filteredMembers) { member in
                        NavigationLink(destination: MemberDetailView(member: member)) {
                            HStack {
                                AsyncImage(url: URL(string: member.profileImageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    HStack() {
                                        Text(member.formalDisplayName + " " + (member.brand ?? ""))
                                            .font(.headline)
                                    }
                                    Text(member.subtitle)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }.searchable(text: $viewModel.searchText)
                }
            }
            .navigationTitle("BNK48 Members")
            .onAppear {
                viewModel.fetchMembers()
            }
        }
    }
}

#Preview {
    ContentView()
}
