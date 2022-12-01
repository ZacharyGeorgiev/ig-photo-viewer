//
//  PostMapper.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import TFDomain
import Resolver

struct PostMapper {
    @Injected private var mediaTypeMapper: MediaTypeMapper
    
    func map(from entity: IGPostEntity) async -> IGPost? {
        guard let id = entity.id,
              let caption = entity.caption,
              let type = await mediaTypeMapper.map(from: entity),
              let timestamp = getDate(from: entity.timestamp),
              let username = entity.username else {
            return nil
        }
        return IGPost(
            id: id,
            caption: caption,
            type: type,
            timestamp: timestamp,
            username: username
        )
    }
}

private extension PostMapper {
    func getDate(from string: String?) -> Date? {
        guard let string = string else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string)
    }
}
