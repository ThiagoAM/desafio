//
//  DesafioApp.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

@main
struct DesafioApp: App {
    @StateObject private var usersViewModel = UsersViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            UsersScreen(
                usersViewModel: usersViewModel)
        }
    }
}
