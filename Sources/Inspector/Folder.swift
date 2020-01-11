//
//  Folder.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import Foundation

public class Folder {

    public let url: URL

    public convenience init(path: String) {
        self.init(url: URL(fileURLWithPath: path))
    }

    public convenience init(name: String, in folder: Folder) {
        self.init(url: folder.url.appendingPathComponent(name))
    }

    public init(url: URL) {
        self.url = url
    }

    public var exists: Bool {
        var isDirectory: ObjCBool = false
        return FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue
    }

    public var files: [File] {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey])
            return contents.compactMap({ url in
                guard (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == false else {
                    return nil
                }
                return File(url: url)
            })
        } catch {
            return []
        }
    }

    public var subfolders: [Folder] {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey])
            return contents.compactMap({ url in
                guard (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true else {
                    return nil
                }
                return Folder(url: url)
            })
        } catch {
            return []
        }
    }

    public var size: FileSize {
        (files.map({ $0.size }) + subfolders.map({ $0.size })).reduce(FileSize.empty, +)
    }

    public func create() throws {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
    }
}
