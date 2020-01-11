//
//  FileSize+Hashable.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

extension FileSize: Hashable {

    public static func == (lhs: FileSize, rhs: FileSize) -> Bool {
        lhs.bytes == rhs.bytes
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.bytes)
    }
}
