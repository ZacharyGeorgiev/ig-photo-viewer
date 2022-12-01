//
//  IGPost.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

public struct IGPost {
    public let id: String
    public let caption: String
    public let type: IGMediaType
    public let timestamp: Date
    public let username: String
    
    public init(
        id: String,
        caption: String,
        type: IGMediaType,
        timestamp: Date,
        username: String
    ) {
        self.id = id
        self.caption = caption
        self.type = type
        self.timestamp = timestamp
        self.username = username
    }
}

public extension IGPost {
    var mediaUrl: URL? {
        switch type {
        case .image(let mediaUrl):
            return mediaUrl
        case .carousel(let mediaUrls):
            return mediaUrls.first
        }
    }
}
