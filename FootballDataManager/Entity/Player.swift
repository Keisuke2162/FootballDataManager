//
//  Player.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/21.
//

import Foundation

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

/*
 
 "player": {
                 "id": 1100,
                 "name": "E. Haaland",
                 "firstname": "Erling",
                 "lastname": "Braut Haaland",
                 "age": 24,
                 "birth": {
                     "date": "2000-07-21",
                     "place": "Leeds",
                     "country": "England"
                 },
                 "nationality": "Norway",
                 "height": "194 cm",
                 "weight": "88 kg",
                 "injured": false,
                 "photo": "https://media.api-sports.io/football/players/1100.png"
             },
             "statistics": [
                 {
                     "team": {
                         "id": 50,
                         "name": "Manchester City",
                         "logo": "https://media.api-sports.io/football/teams/50.png"
                     },
                     "league": {
                         "id": 39,
                         "name": "Premier League",
                         "country": "England",
                         "logo": "https://media.api-sports.io/football/leagues/39.png",
                         "flag": "https://media.api-sports.io/flags/gb.svg",
                         "season": 2023
                     },
                     "games": {
                         "appearences": 19,
                         "lineups": 18,
                         "minutes": 1581,
                         "number": null,
                         "position": "Attacker",
                         "rating": "7.452631",
                         "captain": false
                     },
                     "substitutes": {
                         "in": 1,
                         "out": 4,
                         "bench": 1
                     },
                     "shots": {
                         "total": 61,
                         "on": 36
                     },
                     "goals": {
                         "total": 16,
                         "conceded": 0,
                         "assists": 5,
                         "saves": null
                     },
                     "passes": {
                         "total": 213,
                         "key": 22,
                         "accuracy": 8
                     },
                     "tackles": {
                         "total": 4,
                         "blocks": 1,
                         "interceptions": 1
                     },
                     "duels": {
                         "total": 110,
                         "won": 55
                     },
                     "dribbles": {
                         "attempts": 14,
                         "success": 8,
                         "past": null
                     },
                     "fouls": {
                         "drawn": 17,
                         "committed": 12
                     },
                     "cards": {
                         "yellow": 1,
                         "yellowred": 0,
                         "red": 0
                     },
                     "penalty": {
                         "won": null,
                         "commited": null,
                         "scored": 3,
                         "missed": 1,
                         "saved": null
                     }
                 }
             ]
 */
