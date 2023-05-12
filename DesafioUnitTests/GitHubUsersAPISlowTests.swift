//
//  GitHubUsersAPISlowTests.swift
//  DesafioUnitTests
//
//  Created by Thiago Martins on 11/05/23.
//

import XCTest
@testable import Desafio

final class GitHubUsersAPISlowTests: XCTestCase {
    var sut: GitHubUsersAPI!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GitHubUsersAPI.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testLoadUsers() async throws {
        // Given
        // When
        let users = try await sut.loadUsers()
        // Then
        XCTAssert(!users.isEmpty)
    }
    
    func testLoadUserDetail() async throws {
        // Given
        // When
        let userDetail = try await sut.loadUserDetail(with: "thiagoam")
        // Then
        XCTAssert(userDetail.name == "Thiago Anderson Martins")
        XCTAssert(userDetail.login == "ThiagoAM")
    }
    
    func testLoadUserRepositories() async throws {
        // Given
        // When
        let userRepositories = try await sut.loadUserRepositories(with: "thiagoam")
        // Then
        XCTAssert(!userRepositories.isEmpty)
        XCTAssert(userRepositories.compactMap({$0.name}).contains("Calculadora-Swift"))
    }
}
