//
//  AuthTokenWorker.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 28/11/2022.
//

import Foundation

public protocol AuthTokenWorker {
    func getToken() async throws -> String
}
