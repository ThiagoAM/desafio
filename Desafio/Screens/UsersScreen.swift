//
//  UsersScreen.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

struct UsersScreen: View {
    @ObservedObject var usersViewModel: UsersViewModel
    
    @State private var searchText = ""
    @State private var userBeingShown: User?
    @State private var isLoading = false
    @State private var searchUserErrorAlertShown = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if usersViewModel.users.isEmpty && searchText.isEmpty {
                        Text("Sorry, no users were found at the moment.")
                            .padding(.horizontal)
                        tryAgainButton
                            .padding()
                    }
                    List {
                        if !searchText.isEmpty {
                            searchButton
                        }
                        ForEach(usersViewModel.users) { user in
                            if user.wasSearched(in: searchText) || searchText.isEmpty {
                                UserListView(user: user)
                                    .onTapGesture {
                                        userBeingShown = user
                                    }
                            }
                        }
                    }
                    .navigationTitle("GitHub Users")
                    .onAppear {
                        Task {
                            isLoading = true
                            try? await usersViewModel.loadUsers()
                            isLoading = false
                        }
                    }
                    .searchable(
                        text: $searchText,
                        prompt: Text("Search by username"))
                    .refreshable {
                        try? await usersViewModel.loadUsers()
                    }
                    .sheet(item: $userBeingShown) { _ in
                        UserDetailScreen(
                            usersViewModel: usersViewModel,
                            user: $userBeingShown)
                    }
                    .alert(isPresented: $searchUserErrorAlertShown) {
                        Alert(
                            title: Text("Something Went Wrong"),
                            message: Text("We couldn't find the username you searched for. Please make sure the username exists or check your internet connection."),
                            dismissButton: .default(Text("OK")))
                    }
                    if isLoading {
                        ProgressView()
                            .scaleEffect(2.0)
                    }
                }
            }
        }
    }
    
    // MARK: - Buttons
    
    private var searchButton: some View {
        Button("Search ...") {
            Task {
                isLoading = true
                try? await usersViewModel.loadUserDetail(
                    with: searchText
                        .trimmingCharacters(in: .whitespaces))
                if let userDetail = usersViewModel.userDetail {
                    userBeingShown = userDetail.asUser
                } else {
                    // didn't manage to find an user with
                    // this username
                    searchUserErrorAlertShown = true
                }
                isLoading = false
            }
        }
    }
    
    private var tryAgainButton: some View {
        Button("Try again") {
            Task {
                isLoading = true
                try? await usersViewModel.loadUsers()
                isLoading = false
            }
        }
    }
}

struct UserListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let loader = GitHubUsersAPI() // Real
//        let loader = GitHubUsersAPIMock() // Mock
        
        let vm = UsersViewModel(
            usersLoader: loader)
        UsersScreen(
            usersViewModel: vm)
    }
}
