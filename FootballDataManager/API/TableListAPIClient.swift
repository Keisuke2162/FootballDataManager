//
//  StandingListAPIClient.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import Foundation


class StandingListAPIClient {
    func getLeagueTable(leagueID: String, completion: @escaping ((Result<StandingsItem, APIError>) -> Void)) {
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
        request.setValue("53110f892335ebb2b23428672aca5826", forHTTPHeaderField: "x-rapidapi-key")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do {
                
                guard let data else { throw APIError.networkError }
                // let json = try JSONSerialization.jsonObject(with: data, options: [])
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
    }
}

