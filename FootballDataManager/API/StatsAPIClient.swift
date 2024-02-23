//
//  StatsAPIClient.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/21.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct StatsAPIClient {
    var getTopScorers: @Sendable (_ type: LeagueType) async throws -> PlayersItem
}

extension StatsAPIClient: TestDependencyKey {
//    static let previewValue = Self(
//        getFixtures: { _ in .mock }
//    )
    static let previewValue = Self(
        getTopScorers: { type in
            do {
                return try await liveValue.getTopScorers(type)
            } catch { return .init(response: []) }
        }
    )
    static let testValue: StatsAPIClient = Self()
}

extension DependencyValues {
    var statsAPIClient: StatsAPIClient {
        get { self[StatsAPIClient.self] }
        set { self[StatsAPIClient.self] = newValue }
    }
}

extension StatsAPIClient: DependencyKey {
    static let liveValue: StatsAPIClient = StatsAPIClient(
        getTopScorers: { type in
            var components = URLComponents(string: "https://v3.football.api-sports.io/fixtures")!
            //https://v3.football.api-sports.io/fixtures?season=2021&league=39
            components.queryItems = [
                .init(name: "season", value: "2023"),
                .init(name: "league", value: type.id)
            ]

            // MARK: - API Request
//            var request = URLRequest(url: components.url!)
//            request.setValue("", forHTTPHeaderField: "x-rapidapi-key")
//            request.httpMethod = "GET"
//
//            let (data, _) = try await URLSession.shared.data(from: request.url!)
//            do {
//                let item = try JSONDecoder().decode(FixturesItem.self, from: data)
//                return item
//            } catch {
//                throw APIError.unknown
//            }
            
            // MARK: - Local JSON File
            guard let fileURL = Bundle.main.url(forResource: type.topScorerResource, withExtension: "json") else {
                throw APIError.unknown
            }

            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let item = try decoder.decode(PlayersItem.self, from: data)
                return item
            } catch {
                throw APIError.unknown
            }
        }
    )
}
