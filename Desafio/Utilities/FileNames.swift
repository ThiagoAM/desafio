//
//  FileNames.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import Foundation

class FileName {
    static let gitHubApiUsers = "github-api-users.json"
    
    static func gitHubApiUserDetail(with login: String) -> String {
        "github-api-user-detail-\(login).json"
    }
    
    static func gitHubApiUserRepositories(with login: String) -> String {
        "github-api-user-repositories-\(login).json"
    }
}
