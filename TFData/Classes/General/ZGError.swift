//
//  ZGError.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

struct ZGError: Error {
    enum ErrorType {
        case generalFailure
        case decoding
    }
    
    let type: ErrorType
    let description: String?
    
    init(_ type: ErrorType, description: String? = nil) {
        self.type = type
        self.description = description
    }
}
