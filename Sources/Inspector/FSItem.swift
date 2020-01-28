//
//  FSItem.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 17.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import Foundation

public class FSItem {

    public let url: URL

    public convenience init(path: String) {
        self.init(url: URL(fileURLWithPath: path))
    }

    public init(url: URL) {
        self.url = url
    }

    public var path: String {
        url.path
    }
}
