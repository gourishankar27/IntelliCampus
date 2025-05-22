//
//  SocialPost.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/22/25.
//

import Foundation
import FirebaseFirestore

/// A social-feed post with likes & comments.
struct SocialPost: Identifiable, Codable {
    @DocumentID var id: String?
    var authorId: String
    var content: String               // text or markdown
    var createdAt: Date
    var likeUserIds: [String] = []    // UIDs that liked
    var comments: [Comment] = []
}

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    var authorId: String
    var content: String
    var createdAt: Date
}
