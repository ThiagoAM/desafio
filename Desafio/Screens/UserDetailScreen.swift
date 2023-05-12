//
//  UserDetailScreen.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

struct UserDetailScreen: View {
    @ObservedObject var usersViewModel: UsersViewModel
    
    @Binding var user: User?
    
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        if let userDetail = usersViewModel.userDetail {
                            UserDetailCardView(
                                userDetail: userDetail)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [Color.red,
                                                 Color.purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(
                                color: Color.black.opacity(0.3),
                                radius: 5, x: 0, y: 5)
                        }
                        if !(usersViewModel.userRepositories ?? []).isEmpty {
                            Text("Repositories")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.vertical)
                            if let repos = usersViewModel.userRepositories {
                                ForEach(repos) { repo in
                                    UserRepositoryListView(
                                        userRepository: repo)
                                    Divider()
                                }
                            }
                        } else {
                            if !isLoading {
                                VStack(alignment: .center) {
                                    Text("Oops! We encountered an issue while attempting to load the user's repositories. Please check your internet connection and try again.")
                                        .padding()
                                    tryAgainButton
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle(user?.login ?? "")
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            user = nil
                        }) {
                            Image(systemName: "xmark")
                        })
                .onAppear {
                    Task {
                        if let login = user?.login {
                            isLoading = true
                            try? await usersViewModel.loadUserDetail(
                                with: login)
                            try? await usersViewModel.loadUserRepository(
                                with: login)
                            isLoading = false
                        }
                    }
                }
                .onDisappear {
                    user = nil
                    usersViewModel.clearUserDetail()
                    usersViewModel.clearUserRepository()
                }
                if isLoading {
                    ProgressView()
                        .scaleEffect(2.0)
                }
            }
        }
    }
    
    // MARK: - Buttons
    
    private var tryAgainButton: some View {
        Button("Try again") {
            Task {
                if let login = user?.login {
                    isLoading = true
                    try? await usersViewModel.loadUserDetail(
                        with: login)
                    try? await usersViewModel.loadUserRepository(
                        with: login)
                    isLoading = false
                }
            }
        }
    }
}

struct UserDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let loader = GitHubUsersAPI() // Real
//        let loader = GitHubUsersAPIMock() // Mock

        let vm = UsersViewModel(
            usersLoader: loader)
        UserDetailScreen(
            usersViewModel: vm,
            user: .constant(User(login: "mojombo", id: 1, nodeID: "", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: "", siteAdmin: false)))
    }
}
