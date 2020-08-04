//
//  Data Model.swift
//  iOS-xToUSDApp
//
//  Created by Dmitry Aksyonov on 03.08.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import Foundation

struct PickerList: Codable {
    var list: [Currency]
}

struct Currency: Codable {
    var name: String
    var tag: String
}

struct Rate: Codable {
    var value: Double
}
