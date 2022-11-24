//
//  ApplicationDependencies.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import Resolver
import TFPresentation
import TFDomain
import TFData
import TFExtensions

final class ApplicationDependencies {
    
    // MARK: Internal properties
    let resolver: Resolver = .main
    
    // MARK: Private properties
    private let assemblies: [Assembly] = [
        TargetAssembly(),
        TFData.TargetAssembly()
    ]
    
    // MARK: Lifecycle
    init() {
        assemblies.forEach({
            $0.assemble(with: resolver)
        })
    }
}
