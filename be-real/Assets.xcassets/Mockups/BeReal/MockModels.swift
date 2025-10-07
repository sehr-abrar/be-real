//
//  MockModels.swift
//  BeReal
//
//  Created by Sehr Abrar on 10/7/25.
//

//
//  MockModels.swift
//  BeReal
//
//  Created by Sehr Abrar on 10/7/25.
//

import SwiftUI

struct User {
    let username: String
    let email: String
}

struct Comment: Identifiable {
    let id = UUID()
    let username: String
    let text: String
}

struct Post: Identifiable {
    let id = UUID()
    let username: String
    var image: Image?        // for uploads
    let imageURL: String?    // for mock URL posts
    let caption: String?
    let location: String?
    let date: Date
    var comments: [Comment] = []

    var timeAgo: String {
        let diff = Int(Date().timeIntervalSince(date))
        if diff < 60 { return "\(diff)s ago" }
        if diff < 3600 { return "\(diff / 60)m ago" }
        if diff < 86400 { return "\(diff / 3600)h ago" }
        return "\(diff / 86400)d ago"
    }
}

struct MockData {
    static let samplePosts: [Post] = [
        Post(
            username: "alex",
            imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMWOz331J1WHr2ecS30fkeB9Q5CX3w6y9wRA&s",
            caption: "Caught the perfect sunset 🌇",
            location: "Los Angeles, CA",
            date: Date().addingTimeInterval(-1800),
            comments: [
                Comment(username: "jamie", text: "That sky is unreal 😍"),
                Comment(username: "taylor", text: "Golden hour goals ✨")
            ]
        ),
        Post(
            username: "morgan",
            imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScte4jKVyFZuPCMg2V9dLB237JVFCofkJWRg&s",
            caption: "Rainy day coffee ☕️",
            location: "Seattle, WA",
            date: Date().addingTimeInterval(-5400),
            comments: [
                Comment(username: "chris", text: "I can smell the coffee ☕️"),
                Comment(username: "alex", text: "So cozy!")
            ]
        ),
        Post(
            username: "taylor",
            imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9TNGpl1wRtPLTGWKmrjNK6o6yktrNpYV-Jw&s",
            caption: "Morning walk vibes 🌿",
            location: nil,
            date: Date().addingTimeInterval(-10800),
            comments: [
                Comment(username: "morgan", text: "Peaceful!"),
                Comment(username: "jamie", text: "I love this trail 🥾")
            ]
        ),
        Post(
            username: "jamie",
            imageURL: "https://pubcrawlnewyork.com/wp-content/uploads/2024/02/times-square-nightlife.jpg",
            caption: "Late night lights 🌃",
            location: "New York, NY",
            date: Date().addingTimeInterval(-14400),
            comments: [
                Comment(username: "alex", text: "City never sleeps 🗽"),
                Comment(username: "morgan", text: "Wow, beautiful shot!")
            ]
        )
    ]
}
