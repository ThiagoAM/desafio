//
//  GitHubUsersAPIMock.swift
//  Desafio
//
//  Created by Thiago Martins on 11/05/23.
//

import Foundation

/// This class can be used when testing, and can be injected in
/// `UsersViewModel` as a dependency.
class GitHubUsersAPIMock: UserLoader {
    func loadUsers() async throws -> [User] {
        throw GitHubUsersError.unknown
    }
    
    func loadUserDetail(with login: String) async throws -> UserDetail {
        throw GitHubUsersError.unknown
    }
    
    func loadUserRepositories(with login: String) async throws -> [UserRepository] {
        throw GitHubUsersError.unknown
    }
}
