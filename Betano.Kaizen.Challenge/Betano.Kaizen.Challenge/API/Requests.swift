//
//  Requests.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

// MARK: - Services

struct Services {

    static private func execute(urlRequest: URLRequest,
                                completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil, let data = data else { completionHandler(.failure(.badURL)) ; return }

            guard let httpResponse = response as? HTTPURLResponse
            else { completionHandler(.success(data)) ; return }

            guard httpResponse.statusCode == 200 else { completionHandler(.failure(.errorFetchingData)) ; return }
            completionHandler(.success(data))
        }
        task.resume()
    }

    static private func decode<T: Decodable>(_ type: T.Type,
                                             data: Data,
                                             completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            completionHandler(.success(result))
        } catch {
            print(">>> Error: \(error)")
            completionHandler(.failure(.errorDecoding))
        }
    }

    static func fetchData<T: Decodable>(_ type: T.Type,
                                        urlRequest: URLRequest?,
                                        completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = urlRequest else { completionHandler(.failure(.badURL)) ; return }
        Services.execute(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                decode(T.self, data: data, completionHandler: completionHandler)
            case .failure(let error):
                print(">>> Error: \(error)")
                completionHandler(.failure(.errorFetchingData))
            }
        }
    }
}

// MARK: - Service Requests

class ServicesRequests {

    static func getListOfSports(completionHandler: @escaping (Result<[GameSection], NetworkError>) -> Void) {
        guard let urlRequest = createRequest(for: API.Repositories.listOfSports,
                                                headerParams: API.UrlRequests.headerParameters)
        else { completionHandler(.failure(.badURL)) ; return }
        execute(responseType: [GameSection].self,
                urlRequest: urlRequest,
                completionHandler: completionHandler)
    }

    private static func execute<T: Decodable>(responseType: T.Type,
                                              urlRequest: URLRequest,
                                              completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        Services.fetchData(responseType,
                           urlRequest: urlRequest,
                           completionHandler: completionHandler)
    }

    private static func createRequest(for urlPath: String,
                                      headerParams: [String: String]) -> URLRequest? {
        guard let urlRequest = API.UrlRequests.composeUrlRequest(for: urlPath, headerParams: headerParams) else { return nil }
        return urlRequest
    }
}
