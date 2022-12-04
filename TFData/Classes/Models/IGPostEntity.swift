//
//  IGPostEntity.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//

import Foundation

// swiftlint:disable identifier_name
struct IGPostEntity: Decodable {
    public let id: String?
    public let caption: String?
    public let media_type: String?
    public let media_url: String?
    public let permalink: String?
    public let timestamp: String?
    public let username: String?
    public let children: Children?
}

struct Children: Decodable {
    let data: [ChildrenID]?
}

struct ChildrenID: Decodable {
    let id: String?
}
