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
        resolver.register(ImagesWorker.self, ImagesService.init)
        resolver.register(ImageMapper.self, ImageMapper.init)
        
        resolver.register { MoyaProvider<Instagram>() }
        resolver.register { JSONDecoder() }
        
    }
}
