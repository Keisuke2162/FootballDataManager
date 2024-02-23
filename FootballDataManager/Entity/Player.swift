//
//  Player.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/21.
//

import Foundation

struct PlayersItem: Codable {
    let response: [Player]
}

struct Player: Codable, Equatable, Identifiable, Sendable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
     }

    let id: Int
    let name: String
    let imageURL: URL?
    let statistics: [Statistics]
}

struct Statistics: Codable, Identifiable, Sendable {
    var id: Int {
        team.id
    }
    let team: Team
    let goals: Goals
}

struct Goals: Codable {
    let total: Int?
}
