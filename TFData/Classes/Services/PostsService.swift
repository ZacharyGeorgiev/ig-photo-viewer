//
//  PostsService.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import TFDomain
import Resolver
import Moya

struct PostsService: PostsWorker {
    @Injected private var instagramProvider: MoyaProvider<Instagram>
    @Injected private var jsonDecoder: JSONDecoder
    @Injected private var mediaTypeMapper: MediaTypeMapper
    @Injected private var postsMapper: PostsMapper
    @Injected private var authTokenWorker: AuthTokenWorker
    
    func getPosts() async throws -> [IGPost] {
        let postEntities = try await getPostEntities()
        let posts = await postsMapper.map(from: postEntities)
        return posts
    }
}

private extension PostsService {
    func getPostEntities() async throws -> [IGPostEntity] {
        let authToken = try await authTokenWorker.getToken()
        return try await withCheckedThrowingContinuation { continuation in
            instagramProvider.request(.getPosts(accessToken: authToken)) { result in
                switch result {
                case .success(let response):
                    guard response.statusCode == 200 else {
                        return continuation.resume(throwing: getErrorFromResponse(response))
                    }
                    guard let postEntities = try? response.map(
                        [IGPostEntity].self,
                        atKeyPath: "data",
                        using: jsonDecoder,
                        failsOnEmptyData: true
                    ) else {
                        return continuation.resume(throwing: ZGError(.decoding))
                    }
                    continuation.resume(returning: postEntities)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getErrorFromResponse(_ response: Response) -> ZGError {
        guard let errorEntity = try? response.map(
            IGErrorEntity.self,
            atKeyPath: "error",
            using: jsonDecoder,
            failsOnEmptyData: true
        ) else { return .init(.generalFailure) }
        if errorEntity.code == 190 { return .init(.sessionExpired) }
        return .init(.generalFailure)
    }
}
