//
//  FileOperation.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 16.05.23.
//  Copyright (c) 2023 Philip Niedertscheider. All rights reserved.
//

import Foundation

/// Helper structure used to define a list of necessary file operations
public enum FileOperation {

    case write(data: Data, to: File)

    case copyFile(from: File, to: File)
    case copyFolder(from: Folder, to: Folder)

}
