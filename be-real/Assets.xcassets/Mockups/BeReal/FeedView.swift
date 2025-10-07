//
//  FeedView.swift
//  BeReal
//
//  Created by Sehr Abrar on 10/7/25.
//

import SwiftUI

struct FeedView: View {
    let currentUser: User
    let onLogout: () -> Void

    @State private var posts: [Post] = MockData.samplePosts
    @State private var showingUpload = false
    @State private var commentTexts: [UUID: String] = [:]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach($posts) { $post in
                        // ⚡ Extract bindingText locally to fix compiler bug
                        let bindingText = Binding(
                            get: { commentTexts[post.id, default: ""] },
                            set: { commentTexts[post.id] = $0 }
                        )

                        PostView(post: $post, currentUser: currentUser, commentText: bindingText)
                    }
                }
                .padding(.vertical)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("BeReal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") { onLogout() }
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingUpload = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showingUpload) {
                UploadView(currentUser: currentUser) { newPost in
                    posts.insert(newPost, at: 0)
                }
            }
        }
    }
}

// PostView renders a single post
struct PostView: View {
    @Binding var post: Post
    let currentUser: User
    @Binding var commentText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(post.username).bold().foregroundColor(.white)
                Spacer()
                Text(post.timeAgo).font(.caption).foregroundColor(.gray)
            }

            if let img = post.image {
                img.resizable().scaledToFit().cornerRadius(10)
            } else if let urlString = post.imageURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit().cornerRadius(10)
                } placeholder: {
                    Color.gray.opacity(0.3).frame(height: 200).cornerRadius(10)
                }
            } else {
                Rectangle().fill(Color.gray.opacity(0.2)).frame(height: 200).cornerRadius(10)
            }

            if let caption = post.caption {
                Text(caption).foregroundColor(.white)
            }

            if let location = post.location {
                Text("📍 \(location)").foregroundColor(.gray).font(.caption)
            }

            Divider().background(Color.gray)

            VStack(alignment: .leading, spacing: 4) {
                ForEach(post.comments) { comment in
                    HStack {
                        Text("\(comment.username):").bold().foregroundColor(.white)
                        Text(comment.text).foregroundColor(.white)
                    }
                }

                HStack {
                    TextField("Add a comment...", text: $commentText)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 30)

                    Button("Post") {
                        let text = commentText.trimmingCharacters(in: .whitespaces)
                        guard !text.isEmpty else { return }
                        post.comments.append(Comment(username: currentUser.username, text: text))
                        commentText = ""
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
