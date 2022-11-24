//
//  SingletonAssembly.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import Foundation
import Resolver
import TFExtensions

// swiftlint:disable force_cast no_space_in_method_call
final class SingletonAssembly: Assembly {
    
    // MARK: Internal methods
    func assemble(with resolver: Resolver) {
        resolver.register {
            (resolver.resolve(UIApplication.self).delegate as! AppDelegate)
        }
        resolver.register { return UIScreen.main }
        resolver.register { return UIScreen.main }
        resolver.register { return UIWindow() }
        resolver.register { return UIApplication.shared }
        resolver.register { return UserDefaults.standard }
    }
}
