//
//  FixtureDetail.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/25.
//

import Foundation

struct FixtureDetailItem: Codable {
    let response: FixtureDetail
}

struct FixtureDetail: Codable, Equatable, Identifiable, Sendable {
    static func == (lhs: FixtureDetail, rhs: FixtureDetail) -> Bool {
        lhs.id == rhs.id
    }

    var id: Int {
        team.id
    }
    let team: FixtureTeam
    let statistics: [Statictics]
}

struct Statictics: Codable {
    let type: StatisticType
    let value: String?
}

enum StatisticType: String, Codable {
    case shotsOnGoal = "Shots on Goal"
    case shotsOffGoal = "Shots off Goal"
    case totalShots = "Total Shots"
    case blockedShots = "Blocked Shots"
    case shotsInsideBox = "Shots insidebox"
    case shotsOutsideBox = "Shots outsidebox"
    case fouls = "Fouls"
    case cornerKicks = "Corner Kicks"
    case offsides = "Offsides"
    case ballPossession = "Ball Possession"
    case yellowCards = "Yellow Cards"
    case redCards = "Red Cards"
    case goalkeeperSaves = "Goalkeeper Saves"
    case totalPasses = "Total passes"
    case passesAccurate = "Passes accurate"
    case passesPercentage = "Passes %"
    case expectedGoals = "expected_goals"
}
