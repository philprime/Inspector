//
//  Inspector.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 29.06.20.
//  Copyright (c) 2023 Philip Niedertscheider. All rights reserved.
//

import Darwin

public class Inspector {

    public static var currentWorkingDirectory: Folder! {
        guard let cwd = getcwd(nil, Int(PATH_MAX)),
              let path = String(validatingUTF8: cwd) else {
            return nil
        }
        return Folder(path: path)
    }

    /// Creates an unique temporary file
    ///
    /// See `man mkstemp` for details
    ///
    /// - Throws:
    ///    - `InspectorError.invalidTempFileTemplate` - if path template is invalid
    ///    - `InspectorError.failedToCreateFile` - if low-level file creation failed
    /// - Returns: `File`, with path to newly created file
    public static func createTemporaryFile() throws -> File {
        var buffer = [CChar](repeating: 0, count: Int(PATH_MAX))
        guard tempFileTemplate.getCString(&buffer, maxLength: Int(PATH_MAX), encoding: String.Encoding.utf8) else {
            throw InspectorError.invalidTempFileTemplate
        }
        guard mkstemp(&buffer) != -1 else {
            throw InspectorError.failedToCreateFile(String(cString: strerror(errno)))
        }
        return File(path: String(cString: buffer))
    }

    /// Creates an unique temporary folder
    ///
    /// See `man mkdtemp` for details
    ///
    /// - Throws:
    ///    - `InspectorError.invalidTempFileTemplate` - if path template is invalid
    ///    - `InspectorError.failedToCreateFile` - if low-level folder creation failed
    /// - Returns: `File`, with path to newly created folder
    public static func createTemporaryFolder() throws -> Folder {
        var buffer = [CChar](repeating: 0, count: Int(PATH_MAX))
        guard tempFileTemplate.getCString(&buffer, maxLength: Int(PATH_MAX), encoding: String.Encoding.utf8) else {
            throw InspectorError.invalidTempFileTemplate
        }
        guard let fd = mkdtemp(&buffer) else {
            throw InspectorError.failedToCreateFile(String(cString: strerror(errno)))
        }
        return Folder(path: String(cString: fd))
    }

    // MARK: - Helpers

    private static var tempFileTemplate: String {
        var tempDir = String(cString: getenv("TMPDIR"))
        if tempDir.isEmpty {
            tempDir = "/tmp"
        }
        return tempDir + "tmp.XXXXXXXX"
    }
}
