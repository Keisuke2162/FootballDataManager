//
//  ScheduleAPIClient.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/09.
//

import Foundation

final class ScheduleAPIClient {
    func getLeagueTable(leagueID: String, completion: @escaping ((Result<FixtureResponse, APIError>) -> Void)) {
        guard let apiURL = URL(string: "https://v3.football.api-sports.io/standings") else {
            return completion(.failure(.invalidURL))
        }

        var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            .init(name: "season", value: "2023"),
            .init(name: "league", value: leagueID)
        ]

        guard let url = urlComponents?.url else {
            return completion(.failure(.invalidURL))
        }

        var request = URLRequest(url: url)
        request.setValue("", forHTTPHeaderField: "x-rapidapi-key")
        request.httpMethod = "GET"

        if let fileURL = Bundle.main.url(forResource: "foorball_api_fixtures_2023_39", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let jsonData = try decoder.decode(FixtureResponse.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(.unknown))
            }
        } else {
            print("OMG")
        }
        
        /*
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do {
                guard let data else { throw APIError.networkError }
                guard let item = try? JSONDecoder().decode(StandingsItem.self, from: data) else {
                    throw APIError.noneValue
                }
                DispatchQueue.main.async {
                    completion(.success(item))
                }
            } catch {
                guard let apiError = error as? APIError else {
                    completion(.failure(.unknown))
                    return
                }
                completion(.failure(apiError))
            }
        }.resume()
         */
    }
}

