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
}
