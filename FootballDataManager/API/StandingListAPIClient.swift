//
//  StandingListAPIClient.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import Foundation

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
    
    
    /*
     Concurrencyを使わない旧実装
     */
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
        request.setValue("", forHTTPHeaderField: "x-rapidapi-key")
        request.httpMethod = "GET"
        
        if let fileURL = Bundle.main.url(forResource: "football_api_standings_2023_39", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(StandingsItem.self, from: data)
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
