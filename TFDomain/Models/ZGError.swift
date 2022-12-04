//
//  ZGError.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 04/12/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

public struct ZGError: Error {
    public enum ErrorType {
        case generalFailure
        case decoding
        case sessionExpired
        case accessTokenMissing
    }
    
    public let type: ErrorType
    public let description: String?
    
    public init(_ type: ErrorType, description: String? = nil) {
        self.type = type
        self.description = description
    }
}
