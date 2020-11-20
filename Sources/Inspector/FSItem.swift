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

    public func path(relativeTo base: FSItem) -> String {
        // Remove/replace "." and "..", make paths absolute:
        let destComponents = url.standardized.resolvingSymlinksInPath().pathComponents
        let baseComponents = base.url.standardized.resolvingSymlinksInPath().pathComponents

        // Find number of common path components:
        var i = 0
        while i < min(destComponents.count, baseComponents.count)
            && destComponents[i] == baseComponents[i] {
                i += 1
        }

        // Build relative path:
        var relComponents = Array(repeating: "..", count: baseComponents.count - i)
        relComponents.append(contentsOf: destComponents[i...])
        return relComponents.joined(separator: "/")
    }
}
