//
//  UserDetail+User.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import Foundation

extension UserDetail {
    var asUser: User {
        User(login: login, id: id, nodeID: nodeID, avatarURL: avatarURL, gravatarID: gravatarID, url: url, htmlURL: htmlURL, followersURL: followersURL, followingURL: followingURL, gistsURL: gistsURL, starredURL: starredURL, subscriptionsURL: subscriptionsURL, organizationsURL: organizationsURL, reposURL: reposURL, eventsURL: eventsURL, receivedEventsURL: receivedEventsURL, type: type, siteAdmin: siteAdmin)
    }
}
