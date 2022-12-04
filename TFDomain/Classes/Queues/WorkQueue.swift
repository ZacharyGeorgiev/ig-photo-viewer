//
//  WorkQueue.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 04/12/2022.
//

import Foundation

public protocol WorkQueue {
    func async(execute: @escaping () -> Void)
}
