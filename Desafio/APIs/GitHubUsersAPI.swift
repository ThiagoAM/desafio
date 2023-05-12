//
//  GitHubUsersAPI.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import Foundation
import Alamofire

/// Main source of data for this app. Loads user data from `api.github.com`,
/// then caches it before returing the decoded data.
/// - Check `FMCache.swift` for more info on the caching system.
/// - Check `Alamofire+FMCache.swift` for more info on how the `AF.cachedRequest`
///          methhod works.
class GitHubUsersAPI: UserLoader {
    static let shared = GitHubUsersAPI()
    
    private let userListCache = FMCache<[User]>()
    private let userDetailCache = FMCache<UserDetail>()
    private let userRepositoriesCache = FMCache<[UserRepository]>()
    
    func loadUsers() async throws -> [User] {
        do {
            if let users = try await AF.cachedRequest(
                using: userListCache,
                url: "https://api.github.com/users",
                fileName: FileName.gitHubApiUsers) {
                return users
            }
            if DevShortcuts.gitUsersApiDebugPrintEnabled {
                print("Unkown error")
            }
            throw GitHubUsersError.unknown
        } catch let error {
            if DevShortcuts.gitUsersApiDebugPrintEnabled {
                print(error.localizedDescription)
            }
            throw error
        }
    }
    
    func loadUserDetail(with login: String) async throws -> UserDetail {
        do {
            if let userDetail = try await AF.cachedRequest(
                using: userDetailCache,
                url: "https://api.github.com/users/\(login)",
                fileName: FileName.gitHubApiUserDetail(with: login)) {
                return userDetail
            }
            if DevShortcuts.gitUsersApiDebugPrintEnabled {
                print("Unkown error")
            }
            throw GitHubUsersError.unknown
        } catch let error {
            if DevShortcuts.gitUsersApiDebugPrintEnabled {
                print(error.localizedDescription)
            }
            throw error
        }
    }
    
    func loadUserRepositories(with login: String) async throws -> [UserRepository] {
        do {
            if let userRepositories = try await AF.cachedRequest(
                using: userRepositoriesCache,
                url: "https://api.github.com/users/\(login)/repos",
                fileName: FileName.gitHubApiUserRepositories(with: login)) {
                return userRepositories
            }
            throw GitHubUsersError.unknown
        } catch let error {
            throw error
        }
    }
}
