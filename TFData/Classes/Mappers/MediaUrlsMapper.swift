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
        var urls: [(index: Int, url: URL)] = []
        await ids.enumerated().asyncForEach { index, id in
            guard let url = await mediaUrlWorker.getMediaUrl(for: id) else { return }
            urls.append((index: index, url: url))
        }
        let sortedUrls = urls.sorted(by: { $0.index < $1.index })
        return sortedUrls.map({ $0.url })
    }
}
