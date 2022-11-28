//
//  IGImageEntity.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
struct IGImageEntity: Decodable {
    public let id: String?
    public let caption: String?
    public let media_type: String?
    public let media_url: String?
    public let permalink: String?
    public let timestamp: String?
    public let username: String?
}
