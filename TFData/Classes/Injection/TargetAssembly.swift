//
//  TargetAssembly.swift
//  TFData
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import Resolver
import TFExtensions
import TFDomain
import Moya

public final class TargetAssembly: Assembly {
    // MARK: Lifecycle
    public init() { }
    
    // MARK: Public methods
    public func assemble(with resolver: Resolver) {
        resolver.register(WorkQueue.self, BackgroundWorkQueue.init).scope(.application)
        
        resolver.register(PostsWorker.self, PostsService.init)
        resolver.register(AuthTokenWorker.self, AuthTokenService.init)
        resolver.register(MediaUrlWorker.self, MediaUrlService.init)
        
        resolver.register(PostMapper.self, PostMapper.init)
        resolver.register(PostsMapper.self, PostsMapper.init)
        resolver.register(MediaTypeMapper.self, MediaTypeMapper.init)
        resolver.register(MediaUrlMapper.self, MediaUrlMapper.init)
        resolver.register(MediaUrlsMapper.self, MediaUrlsMapper.init)
        
        resolver.register { MoyaProvider<Instagram>() }
        resolver.register { MoyaProvider<NPoint>() }
        resolver.register { JSONDecoder() }
        
    }
}
