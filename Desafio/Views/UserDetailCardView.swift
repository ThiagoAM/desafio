//
//  UserDetailCardView.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

struct UserDetailCardView: View {
    let userDetail: UserDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(userDetail.name ?? "-")")
                .font(.system(size: 30))
                .fontWeight(.bold)
            if let avatarUrl = userDetail.avatarURL {
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                        .overlay(
                            AsyncImage(url: URL(string: avatarUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Color.gray
                            }
                                .clipShape(Circle())
                        )
                    VStack(alignment: .leading) {
                        Text("Public repos: \(userDetail.publicRepos ?? 0)")
                        Text("Followers: \(userDetail.followers ?? 0)")
                        Text("Following: \(userDetail.following ?? 0)")
                    }
                    .padding(.leading)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct UserDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        let userDetail = UserDetail(login: "ThiagoAM", id: 0, nodeID: "", avatarURL: "https://avatars.githubusercontent.com/u/11469512?v=4", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: "", siteAdmin: false, name: "Thiago Anderson Martins", company: "Foton", blog: "", location: "", twitterUsername: "", publicRepos: 20, publicGists: 0, followers: 0, following: 0, createdAt: "", updatedAt: "")
        UserDetailCardView(userDetail: userDetail)
            .previewLayout(.fixed(width: 320, height: 300))
    }
}
