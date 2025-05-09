import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    var id: String?
    let email: String
    let name: String
    let role: UserRole
    var profileImageURL: String?
    
    enum UserRole: String, Codable {
        case employee
        case employer
    }
} 