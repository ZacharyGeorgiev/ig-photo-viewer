//
//  Instagram.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import Moya

enum Instagram {
    case getPosts
}

extension Instagram: TargetType {
    var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        return URL(string: "https://graph.instagram.com")!
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/me/media"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPosts:
            return .requestParameters(
                parameters: [
                    "fields": [
                        "id",
                        "caption",
                        "media_type",
                        "media_url",
                        "permalink",
                        "thumbnail_url",
                        "timestamp",
                        "username"
                    ].joined(separator: ","),
                    "access_token": "IGQVJVVm14MklLcURHWVBTVUFxZAGhDd1BEYjFZATzQyYWltc1pkdEczekUzWHZAVQTB5RTBzd2EzTWNWTTVkcUp0SDNXN0xuSThmWEtmY2w3emwzVDQwbVJqWjg0VUZAJei1Ydk9wZAzRRS2wzdXRyQVpEcDZAueHBRR29oRzJN"
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
