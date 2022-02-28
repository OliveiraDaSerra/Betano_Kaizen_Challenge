//
//  GameSection.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

struct GameSection: Codable {
    var sportID, sportName: String?
    var gamesInfo: [GameInfo]?

    enum CodingKeys: String, CodingKey {
        case sportID = "i"
        case sportName = "d"
        case gamesInfo = "e"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sportID = try values.decodeIfPresent(String.self, forKey: .sportID)
        sportName = try values.decodeIfPresent(String.self, forKey: .sportName)
        gamesInfo = try values.decodeIfPresent([GameInfo].self, forKey: .gamesInfo)
    }
}

extension GameSection {
    func asViewModelSection() -> ViewModelSection {
        let gamesInfoData = gamesInfo?.compactMap({ $0.asField() }) ?? []
        return ViewModelSection(with: sportID,
                                headerFooterData: HeaderFooterData(headerData: HeaderFooterDataContent(title: sportName)),
                                isExpanded: gamesInfoData.count > 0,
                                fields: gamesInfoData)
    }
}

