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
    var getFixtures: @Sendable (_ id: String) async throws -> [Fixture]
}

extension FixtureScheduleClient: TestDependencyKey {
    static let previewValue = Self(
        getFixtures: <#T##(String) async throws -> [Fixture]##(String) async throws -> [Fixture]##(_ id: String) async throws -> [Fixture]#>
    )
}

final class ScheduleAPIClient {
    func getSchedule(leagueID: String) async throws -> FixtureResponse {
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
            let item = try decoder.decode(FixtureResponse.self, from: data)
            return item
        } catch {
            throw APIError.unknown
        }
    }
}

