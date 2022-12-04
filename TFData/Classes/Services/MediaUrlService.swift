//
//  MediaUrlService.swift
//  TFData
//
//  Created by Zahari Georgiev on 01/12/2022.
//

import Foundation
import TFDomain
import Resolver
import Moya

struct MediaUrlService: MediaUrlWorker {
    @Injected private var instagramProvider: MoyaProvider<Instagram>
    @Injected private var authTokenWorker: AuthTokenWorker
    @Injected private var mediaUrlMapper: MediaUrlMapper
    
    func getMediaUrl(for id: String) async -> URL? {
        let authToken = (try? await authTokenWorker.getToken()) ?? ""
        return await withCheckedContinuation { continuation in
            instagramProvider.request(.getPost(id: id, accessToken: authToken)) { result in
                switch result {
                case .success(let response):
                    guard let mediaUrlEntity = try? response.map(MediaUrlEntity.self) else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: mediaUrlMapper.map(from: mediaUrlEntity))
                case .failure:
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
