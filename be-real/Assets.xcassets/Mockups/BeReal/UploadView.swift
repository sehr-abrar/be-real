import SwiftUI
import PhotosUI

struct UploadView: View {
    let currentUser: User
    var onPost: (Post) -> Void

    @Environment(\.dismiss) var dismiss
    @State private var caption = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let image = selectedImage {
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(12)
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 300)
                        .overlay(Text("Select a Photo").foregroundColor(.white))
                }

                PhotosPicker("Choose Photo", selection: $selectedItem, matching: .images)
                    .onChange(of: selectedItem, perform: { newValue in
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImage = Image(uiImage: uiImage)
                            }
                        }
                    })
                    .foregroundColor(.white)

                TextField("Write a caption...", text: $caption)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Button("Post") {
                    let newPost = Post(
                        username: currentUser.username,
                        image: selectedImage,
                        imageURL: nil,
                        caption: caption.isEmpty ? nil : caption,
                        location: "New York, NY",
                        date: Date()
                    )
                    onPost(newPost)
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
