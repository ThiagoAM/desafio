//
//  UserRepositoryListView.swift
//  Desafio
//
//  Created by Thiago Martins on 11/05/23.
//

import SwiftUI

/// View intended to be used as a `List` item. Displays
/// some repository data from a given `UserRepository`.
struct UserRepositoryListView: View {
    let userRepository: UserRepository
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(userRepository.name ?? "-")")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                Spacer()
                HStack {
                    Image(systemName: "star")
                    Text("\(userRepository.stargazersCount ?? 0)")
                }
                .opacity(0.5)
            }
            .padding(.bottom)
            
            HStack {
                HStack {
                    Image(systemName: "eye")
                    Text("\(userRepository.watchersCount ?? 0)")
                }
                .opacity(0.5)
                .padding(.trailing)
                HStack {
                    Image(systemName: "arrow.triangle.branch")
                    Text("\(userRepository.forksCount ?? 0)")
                }
                .opacity(0.5)
            }
        }
    }
}

struct UserRepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let userRepository = UserRepository(id: 0, nodeID: "", name: "RepoName", fullName: "", welcomePrivate: false, owner: nil, htmlURL: "", description: "", fork: false, url: "", forksURL: "", keysURL: "", collaboratorsURL: "", teamsURL: "", hooksURL: "", issueEventsURL: "", eventsURL: "", assigneesURL: "", branchesURL: "", tagsURL: "", blobsURL: "", gitTagsURL: "", gitRefsURL: "", treesURL: "", statusesURL: "", languagesURL: "", stargazersURL: "", contributorsURL: "", subscribersURL: "", subscriptionURL: "", commitsURL: "", gitCommitsURL: "", commentsURL: "", issueCommentURL: "", contentsURL: "", compareURL: "", mergesURL: "", archiveURL: "", downloadsURL: "", issuesURL: "", pullsURL: "", milestonesURL: "", notificationsURL: "", labelsURL: "", releasesURL: "", deploymentsURL: "", gitURL: "", sshURL: "", cloneURL: "", svnURL: "", homepage: "", size: 0, stargazersCount: 10, watchersCount: 2, language: "pt-br", hasIssues: false, hasProjects: false, hasDownloads: false, hasWiki: false, hasPages: false, hasDiscussions: false, forksCount: 3, archived: false, disabled: false, openIssuesCount: 0, allowForking: false, isTemplate: false, webCommitSignoffRequired: false, visibility: "", forks: 0, openIssues: 0, watchers: 0, defaultBranch: "")
        UserRepositoryListView(userRepository: userRepository)
            .previewLayout(.fixed(width: 320, height: 200))
    }
}
