//
//  MediaTypeMapper.swift
//  TFData
//
//  Created by Zahari Georgiev on 01/12/2022.
//

import Foundation
import TFDomain
import Resolver

struct MediaTypeMapper {
    @Injected private var mediaUrlsMapper: MediaUrlsMapper
    
    func map(from entity: IGPostEntity) async -> IGMediaType? {
        switch entity.media_type {
        case "IMAGE":
            guard let urlString = entity.media_url,
                  let url = URL(string: urlString) else {
                return nil
            }
            return .image(mediaUrl: url)
        case "CAROUSEL_ALBUM":
            guard let childrenIds = entity.children?.data?.compactMap({ $0.id }),
                  let urls = await mediaUrlsMapper.map(from: childrenIds) else {
                return nil
            }
            return .carousel(mediaUrls: urls)
        default:
            return nil
        }
    }
}
