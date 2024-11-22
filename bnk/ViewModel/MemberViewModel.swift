import Foundation

class MemberViewModel: ObservableObject {
    @Published var members: [Member] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    
    var filteredMembers: [Member] {
            if searchText.isEmpty {
                return members
            } else {
                return members.filter {
                    $0.displayName.localizedCaseInsensitiveContains(searchText) ||
                    $0.displayName.localizedCaseInsensitiveContains(searchText) ||
                    $0.displayNameEn.localizedCaseInsensitiveContains(searchText) ||
                    $0.formalDisplayName.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

    func fetchMembers() {
        guard let url = URL(string: "https://public.bnk48.io/members/all") else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode([Member].self, from: data)
                    self.members = decodedData
                } catch {
                    self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
