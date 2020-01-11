//
//  TemporaryFolder.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import Foundation

class TemproraryFolder: Folder {

    init() throws {
        let fm = FileManager.default
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        try fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        super.init(url: url)
    }
}
