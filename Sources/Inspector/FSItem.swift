//
//  FSItem.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 17.01.20.
//  Copyright (c) 2023 Philip Niedertscheider. All rights reserved.
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

    public var name: String {
        url.lastPathComponent
    }

    public var `extension`: String {
        url.pathExtension
    }

    public func path(relativeTo base: FSItem) -> String {
        // Remove/replace "." and "..", make paths absolute:
        let destComponents = url.standardized.resolvingSymlinksInPath().pathComponents
        let baseComponents = base.url.standardized.resolvingSymlinksInPath().pathComponents

        // Find number of common path components:
        var count = 0
        while count < min(destComponents.count, baseComponents.count)
            && destComponents[count] == baseComponents[count] {
                count += 1
        }

        // Build relative path:
        var relComponents = Array(repeating: "..", count: baseComponents.count - count)
        relComponents.append(contentsOf: destComponents[count...])
        return relComponents.joined(separator: "/")
    }
}
