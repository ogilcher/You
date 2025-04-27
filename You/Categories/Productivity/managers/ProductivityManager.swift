//
//  ProductivityManager.swift
//  You
//
//  Created by Oliver Gilcher on 4/26/25.
//

import Foundation
import FirebaseFirestore

struct DBProductivityUser: Codable {
    let userId: String
    let dateCreated: Timestamp
    let taskList: [Task]?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.dateCreated = Timestamp()
        self.taskList = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dateCreated = "date_created"
        case taskList = "task_list"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.dateCreated = try container.decode(Timestamp.self, forKey: .dateCreated)
        self.taskList = try container.decodeIfPresent([Task].self, forKey: .taskList)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.taskList, forKey: .taskList)
    }
}

final class ProductivityManager {
    static let shared = ProductivityManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func productivityDocument(userId: String) -> DocumentReference {
        userCollection.document(userId).collection("apps").document("productivity")
    }
    
    func createNewUser() async throws {
        let user = DBProductivityUser(auth: try AuthenticationManager.shared.getAuthenticatedUser())
        try productivityDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBProductivityUser {
        try await productivityDocument(userId: userId).getDocument(as: DBProductivityUser.self)
    }
    
}
