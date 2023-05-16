//
//  Data+File.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright (c) 2023 Philip Niedertscheider. All rights reserved.
//

import Foundation

extension Data {

    public func write(to file: File) throws {
        if !file.exists {
            try file.touch()
        }
        try write(to: file.url)
    }
}
