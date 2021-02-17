// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - User1
struct User1: Codable {
    let user: [UserElement1]
}

// MARK: - UserElement1
struct UserElement1: Codable {
    let durum: Bool
    let mesaj: String
    let bilgiler: Bilgiler1
}

// MARK: - Bilgiler1
struct Bilgiler1: Codable {
    let userID, userName, userSurname, userEmail: String
    let userPhone, face, faceID: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName, userSurname, userEmail, userPhone, face, faceID
    }
}
