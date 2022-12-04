//
//  MediaUrlWorker.swift
//  TFDomain
//
//  Created by Zahari Georgiev on 01/12/2022.
//

import Foundation

public protocol MediaUrlWorker {
    func getMediaUrl(for id: String) async -> URL?
}
