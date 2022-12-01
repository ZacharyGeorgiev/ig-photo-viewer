//
//  PostsWorker.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

public protocol PostsWorker {
    func getPosts() async throws -> [IGPost]
}
