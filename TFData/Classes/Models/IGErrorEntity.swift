//
//  IGErrorEntity.swift
//  TFData
//
//  Created by Zahari Georgiev on 04/12/2022.
//

import Foundation

// swiftlint:disable identifier_name
struct IGErrorEntity: Decodable {
    let message: String?
    let type: String?
    let code: Int?
    let fbtrace_id: String?
}
