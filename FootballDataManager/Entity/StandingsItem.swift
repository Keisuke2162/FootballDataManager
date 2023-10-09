//
//  StandingsItem.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import Foundation

struct StandingsItem: Codable {
    let response: [StandingResponse]
}

struct StandingResponse: Codable {
    let league: LeagueItem
}

struct LeagueItem: Codable {
    let standings: [[Standing]]
}

struct Standing: Codable {
    let rank: Int
    let team: TeamInfo
    let points: Int
    let goalsDiff: Int
    let all: AllGameInformation
}

struct TeamInfo: Codable {
    let id: Int
    let name: String
    let logo: String
}

struct AllGameInformation: Codable {
    let played: Int
    let win: Int
    let draw: Int
    let lose: Int
}
