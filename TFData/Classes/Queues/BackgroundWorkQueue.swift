//
//  BackgroundWorkQueue.swift
//  TFData
//
//  Created by Zahari Georgiev on 04/12/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import TFDomain

struct BackgroundWorkQueue: WorkQueue {
    private let dispatchQueue: DispatchQueue
    
    init() {
        dispatchQueue = DispatchQueue(
            label: "instagram-background-queue",
            qos: .userInitiated,
            attributes: .concurrent
        )
    }
    
    func async(execute: @escaping () -> Void) {
        dispatchQueue.async(execute: execute)
    }
}
