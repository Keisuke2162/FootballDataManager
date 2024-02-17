//
//  ScheduleAPIClient.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/09.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct FixtureScheduleClient {
    var getFixtures: @Sendable (_ id: String) async throws -> FixturesItem
}

extension FixtureScheduleClient: TestDependencyKey {
//    static let previewValue = Self(
//        getFixtures: { _ in .mock }
//    )
    static let previewValue = Self(
        getFixtures: { id in
            do {
                return try await liveValue.getFixtures(id: id)
            } catch { return .init(response: []) }
        }
    )
    static let testValue: FixtureScheduleClient = Self()
}

extension DependencyValues {
    var fixtureScheduleClient: FixtureScheduleClient {
        get { self[FixtureScheduleClient.self] }
        set { self[FixtureScheduleClient.self] = newValue }
    }
}

extension FixtureScheduleClient: DependencyKey {
    static let liveValue: FixtureScheduleClient = FixtureScheduleClient(
        getFixtures: { id in
            var components = URLComponents(string: "https://v3.football.api-sports.io/fixtures")!
            //https://v3.football.api-sports.io/fixtures?season=2021&league=39
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
//                let item = try JSONDecoder().decode(FixturesItem.self, from: data)
//                return item
//            } catch {
//                throw APIError.unknown
//            }
            
            // MARK: - Local JSON File
            guard let fileURL = Bundle.main.url(forResource: "foorball_api_fixtures_2023_39", withExtension: "json") else {
                throw APIError.unknown
            }

            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let item = try decoder.decode(FixturesItem.self, from: data)
                return item
            } catch {
                throw APIError.unknown
            }
        }
    )
}

// 通常のAPIClient実装
final class ScheduleAPIClient {
    func getSchedule(leagueID: String) async throws -> FixturesItem {
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

        guard let fileURL = Bundle.main.url(forResource: "foorball_api_fixtures_2023_39", withExtension: "json") else {
            throw APIError.unknown
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let item = try decoder.decode(FixturesItem.self, from: data)
            return item
        } catch {
            throw APIError.unknown
        }
    }
}

