//
//  UserListView.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

/// View intended to be used as a `List` item. Displays
/// the avatar and the name of a given `User`.
struct UserListView: View {
    let user: User
    
    var body: some View {
        HStack {
            if let avatarUrl = user.avatarURL {
                AsyncImage(url: URL(string: avatarUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 56)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            }
            Text("\(user.login ?? "-")")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.leading)
            
            Spacer()
        }
        .padding()
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(login: "thiagoam", id: 0, nodeID: "", avatarURL: "https://avatars.githubusercontent.com/u/11469512?v=4", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: "", siteAdmin: false)
        UserListView(user: user)
            .previewLayout(.fixed(width: 320, height: 100))
    }
}
