//
//  ContentView.swift
//  BeReal
//
//  Created by Sehr Abrar on 10/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var loggedInUser: User? = nil
    @State private var showingSignup = false

    var body: some View {
        Group {
            if let user = loggedInUser {
                FeedView(currentUser: user) {
                    loggedInUser = nil
                }
            } else if showingSignup {
                SignupView(onSignup: { user in
                    loggedInUser = user
                }, onBack: {
                    showingSignup = false
                })
            } else {
                LoginView(onLogin: { user in
                    loggedInUser = user
                }, onSignupTap: {
                    showingSignup = true
                })
            }
        }
    }
}

struct LoginView: View {
    var onLogin: (User) -> Void
    var onSignupTap: () -> Void
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // dark background

            VStack(spacing: 32) {
                Text("BeReal")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top, 60)

                VStack(spacing: 16) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(white: 0.15))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(white: 0.15))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)

                Button("Log In") {
                    guard !username.isEmpty else { return }
                    onLogin(User(username: username, email: "\(username)@example.com"))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.horizontal)

                Button("Sign up") {
                    onSignupTap()
                }
                .foregroundColor(.gray)

                Spacer()
            }
        }
    }
}

struct SignupView: View {
    var onSignup: (User) -> Void
    var onBack: () -> Void
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 32) {
                Text("Create Account")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top, 60)

                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(white: 0.15))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(white: 0.15))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(white: 0.15))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)

                Button("Sign Up") {
                    guard !username.isEmpty, !email.isEmpty else { return }
                    onSignup(User(username: username, email: email))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.horizontal)

                Button("Back to Login") {
                    onBack()
                }
                .foregroundColor(.gray)

                Spacer()
            }
        }
    }
}
