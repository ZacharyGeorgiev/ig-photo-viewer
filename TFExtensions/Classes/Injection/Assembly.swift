//
//  Assembly.swift
//  TFExtensions
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import Foundation
import Resolver

public protocol Assembly {
    func assemble(with resolver: Resolver)
}
