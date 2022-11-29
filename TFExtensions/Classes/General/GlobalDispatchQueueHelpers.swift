//
//  GlobalDispatchQueueHelpers.swift
//  TFExtensions
//
//  Created by Zahari Georgiev on 29/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

@discardableResult
public func syncSafe<T>(_ work: () -> T) -> T {
    guard !Thread.isMainThread else {
        return work()
    }
    return DispatchQueue.main.sync {
        return work()
    }
}
