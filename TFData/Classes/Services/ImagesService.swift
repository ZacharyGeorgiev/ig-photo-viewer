//
//  ImagesService.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import TFDomain
import Resolver
import Moya

struct ImagesService: ImagesWorker {
    @Injected private var instagramProvider: MoyaProvider<Instagram>
    @Injected private var jsonDecoder: JSONDecoder
    @Injected private var imageMapper: ImageMapper
    @Injected private var authTokenWorker: AuthTokenWorker
    
    func getImages() async throws -> [IGImage] {
        let authToken = await authTokenWorker.getToken()
        return try await withCheckedThrowingContinuation { continuation in
            instagramProvider.request(.getPosts(accessToken: authToken)) { result in
                switch result {
                case .success(let response):
                    guard let imageEntities = try? response.map(
                        [IGImageEntity].self,
                        atKeyPath: "data",
                        using: jsonDecoder,
                        failsOnEmptyData: true
                    ) else {
                        continuation.resume(throwing: ZGError(.decoding))
                        return
                    }
                    let images = imageEntities.compactMap({ imageMapper.map(from: $0) })
                    continuation.resume(returning: images)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
