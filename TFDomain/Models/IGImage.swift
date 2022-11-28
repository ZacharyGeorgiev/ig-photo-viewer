//
//  IGImage.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

public struct IGImage {
    public let id: String
    public let caption: String
    public let type: IGMediaType
    public let url: URL
    public let timestamp: Date
    public let username: String
    
    public init(
        id: String,
        caption: String,
        type: IGMediaType,
        url: URL,
        timestamp: Date,
        username: String
    ) {
        self.id = id
        self.caption = caption
        self.type = type
        self.url = url
        self.timestamp = timestamp
        self.username = username
    }
}
