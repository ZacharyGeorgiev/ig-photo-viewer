//
//  NPoint.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import Moya

enum NPoint {
    case getToken
}

extension NPoint: TargetType {
    var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        return URL(string: "https://api.npoint.io/")!
    }
    
    var path: String {
        switch self {
        case .getToken:
            return "/390d32c3919144e9a788"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getToken:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getToken:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? { return nil }
}
