//
//  AuthTokenService.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import TFDomain
import Resolver
import Moya

struct AuthTokenService: AuthTokenWorker {
    @Injected private var authProvider: MoyaProvider<NPoint>
    
    func getToken() async -> String {
        return await withCheckedContinuation { continuation in
            authProvider.request(.getToken) { result in
                switch result {
                case .success(let response):
                    let authTokenEntity = try? response.map(AuthTokenEntity.self)
                    continuation.resume(returning: authTokenEntity?.token ?? "")
                case .failure(let error):
                    print("an error occurred while fetching auth token: \(error)")
                    continuation.resume(returning: "")
                }
            }
        }
    }
}
