//
//  ReloadInfo.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 01/03/2022.
//

import Foundation

enum ReloadType {
    case section, row
}

struct ReloadInfo {
    var type: ReloadType?
    var section, row: Int?
}
