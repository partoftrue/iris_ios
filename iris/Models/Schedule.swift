import Foundation
import FirebaseFirestore

struct Schedule: Identifiable, Codable {
    var id: String?
    let employeeId: String
    let employerId: String
    let startTime: Date
    let endTime: Date
    let location: String
    let title: String
    var status: ScheduleStatus
    
    enum ScheduleStatus: String, Codable {
        case pending
        case confirmed
        case completed
        case cancelled
    }
} 