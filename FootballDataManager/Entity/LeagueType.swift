//
//  LeagueType.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/18.
//

import Foundation
import SwiftUI

enum LeagueType {
    case england
    case italy
    case spain
}

extension LeagueType {
    var id: String {
        switch self {
        case .england:
            "39"
        case .italy:
            "135"
        case .spain:
            "140"
        }
    }

    var name: String {
        switch self {
        case .england:
            "Premier League"
        case .italy:
            "Serie A"
        case .spain:
            "La Liga"
        }
    }

    var themaColor: Color {
        switch self {
        case .england:
            Color.init("background-premier")
        case .italy:
            Color.init("background-seriea")
        case .spain:
            Color.init("background-laliga")
        }
    }

    var standingResource: String {
        switch self {
        case .england:
            "football_api_standings_2023_39"
        case .italy:
            "football_api_standings_2023_135"
        case .spain:
            "football_api_standings_2023_140"
        }
    }

    var fixturesResource: String {
        switch self {
        case .england:
            "foorball_api_fixtures_2023_39"
        case .italy:
            "foorball_api_fixtures_2023_135"
        case .spain:
            "foorball_api_fixtures_2023_140"
        }
    }
}
