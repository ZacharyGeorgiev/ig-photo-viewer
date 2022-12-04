//
//  WorkQueue.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 04/12/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

public protocol WorkQueue {
    func async(execute: @escaping () -> Void)
}
