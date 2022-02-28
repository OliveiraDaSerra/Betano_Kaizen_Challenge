//
//  NetworkError.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

enum NetworkError: Error {
    case noError, badURL, badFormat, errorDecoding, errorFetchingData
}
