//
//  GameInfo.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

struct GameInfo: Codable {
    var eventID, eventName, sportID: String?
    var eventStartTime: Double?

    enum CodingKeys: String, CodingKey {
        case eventID = "i"
        case eventName = "d"
        case sportID = "si"
        case eventStartTime = "tt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eventID = try values.decodeIfPresent(String.self, forKey: .eventID)
        eventName = try values.decodeIfPresent(String.self, forKey: .eventName)
        sportID = try values.decodeIfPresent(String.self, forKey: .sportID)
        eventStartTime = try values.decodeIfPresent(Double.self, forKey: .eventStartTime)
    }
}

extension GameInfo {
    func asField() -> FieldBase {
        return FieldBase(with: eventName,
                         favourite: false,
                         startTime: eventStartTime)
    }
}
