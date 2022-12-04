//
//  PostsMapper.swift
//  TFData
//
//  Created by Zahari Georgiev on 01/12/2022.
//

import Foundation
import TFDomain
import Resolver

struct PostsMapper {
    @Injected private var postMapper: PostMapper
    
    func map(from entities: [IGPostEntity]) async -> [IGPost] {
        let posts = await entities.asyncMap { entity in
            return await postMapper.map(from: entity)
        }
        return posts.compactMap({ $0 })
    }
}
