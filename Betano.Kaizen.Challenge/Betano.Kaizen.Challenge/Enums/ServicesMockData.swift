//
//  ServicesMockData.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 01/03/2022.
//

import Foundation

enum ServicesMockData {
    case listOfSports

    var filePath: String? {
        switch self {
        case .listOfSports:
            return Bundle.main.path(forResource: "SportsResponseMockData", ofType: "json")
        }
    }

    var url: URL? {
        switch self {
        case .listOfSports:
            guard let path = filePath else { return nil }
            return URL(fileURLWithPath: path)
        }
    }

    var urlRequest: URLRequest? {
        switch self {
        case .listOfSports:
            guard let url = url else { return nil }
            return generateUrlRequest(for: url)
        }
    }

    private func generateUrlRequest(for url: URL?) -> URLRequest? {
        guard let url = url else { return nil }
        return URLRequest(url: url,
                          cachePolicy: API.UrlRequests.Components.cachePolicy,
                          timeoutInterval: API.UrlRequests.Components.timeout)
    }
}
