//
//  Resolver+Extension.swift
//  TFData
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import Resolver

public extension Resolver {    
    @discardableResult
    func register<Service>(_ service: Service.Type, _ initializer: @escaping () -> Service) -> ResolverOptions<Service> {
        return register { initializer() as Service }
    }

}
