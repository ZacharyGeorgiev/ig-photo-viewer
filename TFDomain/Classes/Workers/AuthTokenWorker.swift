//
//  AuthTokenWorker.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

public protocol AuthTokenWorker {
    func getToken() async throws -> String
}
