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
    case getPosts(accessToken: String)
    case getPost(id: String, accessToken: String)
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
        case .getPost(let id, _):
            return "/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPosts, .getPost:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPosts(let accessToken):
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
                        "username",
                        "children"
                    ].joined(separator: ","),
                    "access_token": accessToken
                ],
                encoding: URLEncoding.default
            )
        case .getPost(_, let accessToken):
            return .requestParameters(
                parameters: [
                    "fields": [
                        "id",
                        "media_url"
                    ].joined(separator: ","),
                    "access_token": accessToken
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String: String]? { return nil }
}
