//
//  Fixture.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/09.
//

import Foundation

struct FixturesItem: Codable {
    let response: [Fixture]

    var groupedItems: [String: [Fixture]] {
        Dictionary(grouping: response) { item in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: item.fixture.date)
        }
    }

    var dateKeys: [String] {
        groupedItems.keys.sorted()
    }
}

struct Fixture: Codable, Equatable, Identifiable, Sendable {
    static func == (lhs: Fixture, rhs: Fixture) -> Bool {
        lhs.id == rhs.id
    }
    var id: Int {
        fixture.id
    }
    let fixture: FixtureItem
    let teams: FixtureTeams
    let goals: FixtureGoals
}

struct FixtureItem: Codable {
    let id: Int
    let date: Date
    let status: FixtureStatus
}

struct FixtureStatus: Codable {
    let short: String
}

struct FixtureTeams: Codable {
    let home: FixtureTeam
    let away: FixtureTeam
}

struct FixtureTeam: Codable {
    let id: Int
    let name: String
    let logo: String
    let winner: Bool?
}

struct FixtureGoals: Codable {
    let home: Int?
    let away: Int?
}

// MARK: - Mock
extension FixturesItem {
    static let mock = Self(
        response: [.mock]
    )
}

extension Fixture {
    static let mock = Self(
        fixture: .mock,
        teams: .mock,
        goals: .mock)
}

extension FixtureItem {
    static let mock = Self(
        id: 1035037,
        date: "2023-08-11T19:00:00+00:00".toDate()!,
        status: .mock
    )
}

extension FixtureStatus {
    static let mock = Self(
        short: "FT"
    )
}
extension FixtureTeams {
    static let mock = Self(
        home: .mockHome,
        away: .mockAway
    )
}

extension FixtureTeam {
    static let mockHome = Self(
        id: 44,
        name: "Burnley",
        logo: "https://media-4.api-sports.io/football/teams/44.png",
        winner: false
    )
    static let mockAway = Self(
        id: 50,
        name: "Manchester City",
        logo: "https://media-4.api-sports.io/football/teams/50.png",
        winner: true
    )
}

extension FixtureGoals {
    static let mock = Self(
        home: 3,
        away: 0
    )
}
