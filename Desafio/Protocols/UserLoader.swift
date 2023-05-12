//
//  UserLoader.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

/// A protocol representing a user loader, responsible for loading
/// user-related data from a data source.
protocol UserLoader {
    func loadUsers() async throws -> [User]
    func loadUserDetail(with login: String) async throws -> UserDetail
    func loadUserRepositories(with login: String) async throws -> [UserRepository]
}
