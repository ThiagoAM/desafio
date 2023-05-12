//
//  UserLoader.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

protocol UserLoader {
    func loadUsers() async throws -> [User]
    func loadUserDetail(with login: String) async throws -> UserDetail
    func loadUserRepositories(with login: String) async throws -> [UserRepository]
}
