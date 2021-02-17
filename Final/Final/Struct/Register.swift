// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let register = try? newJSONDecoder().decode(Register.self, from: jsonData)

import Foundation

// MARK: - Register
struct Register: Codable {
    let user: [User]
} 

// MARK: - User
struct User: Codable {
    let durum: Bool
    let mesaj : String
    let kullaniciID: String?

    enum CodingKeys: String, CodingKey {
        case durum, mesaj
        case kullaniciID = "kullaniciId"
    }
}
