struct Member: Identifiable, Codable {
    let id: Int
    let codeName: String
    let displayName: String
    let displayNameEn: String
    let formalDisplayName: String
    let subtitle: String
    let profileImageUrl: String
    let coverImageUrl: String?
    let brand: String
    let caption: String?
    let cityEn: String?
}
