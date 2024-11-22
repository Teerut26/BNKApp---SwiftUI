import SwiftUI

struct MemberDetailView: View {
    let member: Member
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: member.profileImageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                .clipShape(.rect(cornerRadius: 10))
                .padding()

                HStack {
                    Text(member.formalDisplayName + " " + member.brand)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                Text(member.subtitle)
                    .font(.title3)
                    .foregroundColor(.gray)
                
                Text(member.caption ?? "-")
                    .font(.title3)
                    .foregroundColor(.gray)
                Text("Location: "+(member.cityEn ?? "-"))
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .navigationTitle((member.formalDisplayName + " " + (member.brand)))
        }
    }
}
