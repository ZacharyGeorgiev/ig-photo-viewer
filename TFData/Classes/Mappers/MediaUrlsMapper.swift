//
//  MediaUrlsMapper.swift
//  TFData
//
//  Created by Zahari Georgiev on 01/12/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import Resolver
import TFDomain

struct MediaUrlsMapper {
    @Injected private var mediaUrlWorker: MediaUrlWorker
    
    func map(from ids: [String]) async -> [URL]? {
        var urls: [URL] = []
        await ids.asyncForEach { id in
            guard let url = await mediaUrlWorker.getMediaUrl(for: id) else { return }
            urls.append(url)
        }
        return urls
    }
}
