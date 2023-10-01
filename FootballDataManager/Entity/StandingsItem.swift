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
}

struct TeamInfo: Codable {
    let id: Int
    let name: String
    let logo: String
}
