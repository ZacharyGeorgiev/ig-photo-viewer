//
//  MediaUrlMapper.swift
//  TFData
//
//  Created by Zahari Georgiev on 01/12/2022.
//

import Foundation

struct MediaUrlMapper {
    func map(from entity: MediaUrlEntity) -> URL? {
        guard let urlString = entity.media_url else { return nil }
        return URL(string: urlString)
    }
}
