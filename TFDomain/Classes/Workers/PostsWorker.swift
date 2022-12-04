//
//  PostsWorker.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 28/11/2022.
//

import Foundation

public protocol PostsWorker {
    func getPosts() async throws -> [IGPost]
}
