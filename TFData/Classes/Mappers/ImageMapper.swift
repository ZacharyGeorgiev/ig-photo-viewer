//
//  ImageMapper.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import TFDomain

struct ImageMapper {
    func map(from entity: IGImageEntity) -> IGImage? {
        guard let id = entity.id,
              let caption = entity.caption,
              let type = getMediaType(from: entity.media_type),
              let urlString = entity.media_url,
              let url = URL(string: urlString),
              let timestamp = getDate(from: entity.timestamp),
              let username = entity.username else {
            return nil
        }
        return IGImage(
            id: id,
            caption: caption,
            type: type,
            url: url,
            timestamp: timestamp,
            username: username
        )
    }
}

private extension ImageMapper {
    func getMediaType(from string: String?) -> IGMediaType? {
        switch string {
        case "IMAGE":
            return .image
        case "CAROUSEL_ALBUM":
            return .carousel
        default:
            return nil
        }
    }
    
    func getDate(from string: String?) -> Date? {
        guard let string = string else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string)
    }
}
