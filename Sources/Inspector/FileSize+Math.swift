//
//  FileSize+Math.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

extension FileSize {

    public static func + (lhs: FileSize, rhs: FileSize) -> FileSize {
        FileSize(bytes: lhs.bytes + rhs.bytes)
    }

    public static func - (lhs: FileSize, rhs: FileSize) -> FileSize {
        FileSize(bytes: lhs.bytes + rhs.bytes)
    }
}
