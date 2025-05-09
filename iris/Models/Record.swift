import Foundation
import FirebaseFirestore

struct Record: Identifiable, Codable {
    var id: String?
    let userId: String
    let title: String
    let content: String
    let type: RecordType
    let createdAt: Date
    var mediaURL: String?
    
    enum RecordType: String, Codable {
        case text
        case image
        case voice
    }
} 
