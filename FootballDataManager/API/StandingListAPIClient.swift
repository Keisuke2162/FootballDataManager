//
//  StandingListAPIClient.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct StandingClient {
    var getStanding: @Sendable (_ id: String) async throws -> [Standing]
}

extension StandingClient: TestDependencyKey {
//    static let previewValue = Self(getStanding: { _ in [.mock] })
    static let previewValue = Self(
        getStanding: { id in
            do {
                return try await liveValue.getStanding(id)
            } catch { return [] }
        }
    )
    static var testValue: StandingClient = Self()
}

extension DependencyValues {
    var standingClient: StandingClient {
        get { self[StandingClient.self] }
        set { self[StandingClient.self] = newValue }
    }
}

extension StandingClient: DependencyKey {
    static let liveValue: StandingClient = StandingClient(
        getStanding: { id in
            var components = URLComponents(string: "https://v3.football.api-sports.io/standings")!
            components.queryItems = [
                .init(name: "season", value: "2023"),
                .init(name: "league", value: id)
            ]
            // MARK: - API Request
//            var request = URLRequest(url: components.url!)
//            request.setValue("", forHTTPHeaderField: "x-rapidapi-key")
//            request.httpMethod = "GET"
//            
//            let (data, _) = try await URLSession.shared.data(from: request.url!)
//            do {
//                let item = try JSONDecoder().decode(StandingsItem.self, from: data)
//                guard let items = item.response.first?.league.standings.first else {
//                    throw APIError.unknown
//                }
//                return items
//            } catch {
//                throw APIError.unknown
//            }
            
            // MARK: - Local JSON File
            // JSONファイルからモックデータ読み込み
            guard let fileURL = Bundle.main.url(forResource: "football_api_standings_2023_39", withExtension: "json") else {
                throw APIError.unknown
            }

            do {
                let data = try Data(contentsOf: fileURL)
                let item = try JSONDecoder().decode(StandingsItem.self, from: data)
                guard let items = item.response.first?.league.standings.first else {
                    throw APIError.unknown
                }
                return items
            } catch {
                throw APIError.unknown
            }
        }
    )
}

// 通常のAPIClient実装
final class StandingListAPIClient {
    func getStanding(leagueID: String) async throws -> [Standing] {
        guard let apiURL = URL(string: "https://v3.football.api-sports.io/standings") else {
            throw APIError.invalidURL
        }
    
        var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            .init(name: "season", value: "2023"),
            .init(name: "league", value: leagueID)
        ]

        guard let url = urlComponents?.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("", forHTTPHeaderField: "x-rapidapi-key")
        request.httpMethod = "GET"
        
        guard let fileURL = Bundle.main.url(forResource: "football_api_standings_2023_39", withExtension: "json") else {
            throw APIError.unknown
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let item = try JSONDecoder().decode(StandingsItem.self, from: data)
            guard let items = item.response.first?.league.standings.first else {
                throw APIError.unknown
            }
            return items
        } catch {
            throw APIError.unknown
        }
    }
}
