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

    var shopsOnGoal: String? {
        statistics.first(where: { $0.type == .shotsOnGoal })?.value
    }
    var totalShots: String? {
        statistics.first(where: { $0.type == .totalShots })?.value
    }
    var fouls: String? {
        statistics.first(where: { $0.type == .fouls })?.value
    }
    var cornerKicks: String? {
        statistics.first(where: { $0.type == .cornerKicks })?.value
    }
    var offsides: String? {
        statistics.first(where: { $0.type == .offsides })?.value
    }
    var yellowCards: String? {
        statistics.first(where: { $0.type == .yellowCards })?.value
    }
    var redCards: String? {
        statistics.first(where: { $0.type == .redCards })?.value
    }
    var ballPossession: String? {
        statistics.first(where: { $0.type == .ballPossession })?.value
    }
    var expectedGoals: String? {
        statistics.first(where: { $0.type == .expectedGoals })?.value
    }
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
