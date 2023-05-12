//
//  UsersViewModel.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import Foundation

/// ViewModel responsible for handling user related data.
@MainActor class UsersViewModel: ObservableObject {
    static let shared = UsersViewModel()
    
    @Published private(set) var users: [User] = []
    @Published private(set) var userDetail: UserDetail?
    @Published private(set) var userRepositories: [UserRepository]?
    
    private let usersLoader: UserLoader
    
    init(usersLoader: UserLoader = GitHubUsersAPI.shared) {
        self.usersLoader = usersLoader
    }
    
    // MARK: - Loading
    
    func loadUsers() async throws {
        do {
            users = try await usersLoader.loadUsers()
        } catch let error {
            throw error
        }
    }
    
    func loadUserDetail(with login: String) async throws {
        do {
            userDetail = try await usersLoader.loadUserDetail(
                with: login)
        } catch let error {
            throw error
        }
    }
    
    func loadUserRepository(with login: String) async throws {
        do {
            userRepositories = try await usersLoader.loadUserRepositories(
                with: login)
        } catch let error {
            throw error
        }
    }
    
    // MARK: - Intent(s)
    
    func clearUserDetail() {
        userDetail = nil
    }
    
    func clearUserRepository() {
        userRepositories = nil
    }
}
