//
//  TemporaryFolder.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright (c) 2023 Philip Niedertscheider. All rights reserved.
//

import Foundation

public class TemporaryFolder: Folder {

    init() throws {
        let manager = FileManager.default
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        try manager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        super.init(url: url)
    }
}
