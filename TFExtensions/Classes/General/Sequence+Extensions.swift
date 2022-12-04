//
//  Sequence+Extensions.swift
//  TFExtensions
//
//  Created by Zahari Georgiev on 01/12/2022.
//

import Foundation

public extension Sequence {
    func asyncForEach(_ operation: @escaping (Element) async -> Void) async {
        await withTaskGroup(of: Void.self) { group in
            forEach { element in
                group.addTask {
                    await operation(element)
                }
            }
        }
    }
    
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }
}
