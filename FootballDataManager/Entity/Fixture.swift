//
//  Fixture.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/09.
//

import Foundation

struct FixtureResponse: Codable {
    let response: [Fixture]
}

struct Fixture: Codable {
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


/*
 {
     "fixture": {
         "id": 1035037,
         "referee": "Craig Pawson, England",
         "timezone": "UTC",
         "date": "2023-08-11T19:00:00+00:00",
         "timestamp": 1691780400,
         "periods": {
             "first": 1691780400,
             "second": 1691784000
         },
         "venue": {
             "id": 512,
             "name": "Turf Moor",
             "city": "Burnley"
         },
         "status": {
             "long": "Match Finished",
             "short": "FT",
             "elapsed": 90
         }
     },
     "league": {
         "id": 39,
         "name": "Premier League",
         "country": "England",
         "logo": "https://media-4.api-sports.io/football/leagues/39.png",
         "flag": "https://media-4.api-sports.io/flags/gb.svg",
         "season": 2023,
         "round": "Regular Season - 1"
     },
     "teams": {
         "home": {
             "id": 44,
             "name": "Burnley",
             "logo": "https://media-4.api-sports.io/football/teams/44.png",
             "winner": false
         },
         "away": {
             "id": 50,
             "name": "Manchester City",
             "logo": "https://media-4.api-sports.io/football/teams/50.png",
             "winner": true
         }
     },
     "goals": {
         "home": 0,
         "away": 3
     },
     "score": {
         "halftime": {
             "home": 0,
             "away": 2
         },
         "fulltime": {
             "home": 0,
             "away": 3
         },
         "extratime": {
             "home": null,
             "away": null
         },
         "penalty": {
             "home": null,
             "away": null
         }
     }
 },
 */
