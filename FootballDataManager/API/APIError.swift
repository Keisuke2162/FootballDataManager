//
//  APIError.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError
    case noneValue
    case unknown

    var title: String {
        switch self {
        case .noneValue:
            return "値が空で取得されたエラー"
        case .invalidURL:
            return "無効なURLのエラー"
        case .networkError:
            return "ネットワークエラー"
        default:
            return "不明なエラー"
        }
    }
}
