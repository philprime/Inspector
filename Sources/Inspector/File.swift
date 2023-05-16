//
//  File.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright (c) 2023 Philip Niedertscheider. All rights reserved.
//

import Foundation

public class File: FSItem {

    public convenience init(name: String, extension ext: String? = nil, in folder: Folder) {
        var path = folder.url.appendingPathComponent(name)
        if let ext = ext {
            path.appendPathExtension(ext)
        }
        self.init(url: path.resolvingSymlinksInPath())
    }

    public override init(url: URL) {
        super.init(url: url)
    }

    /// Name of this file without the path extension
    public var fileName: String {
        url.deletingPathExtension().lastPathComponent
    }

    public var folder: Folder {
        Folder(url: self.url.deletingLastPathComponent())
    }

    public var exists: Bool {
        FileManager.default.fileExists(atPath: url.path)
    }

    public var size: FileSize {
        guard let fileSizeResourceValue = try? url.resourceValues(forKeys: [.isDirectoryKey, .fileSizeKey]) else {
            return .empty
        }
        if fileSizeResourceValue.isDirectory == true {
            return .empty
        }
        return FileSize(bytes: Int64(fileSizeResourceValue.fileSize ?? 0))
    }

    @discardableResult
    public func touch() throws -> Bool {
        let manager = FileManager.default
        // Create directories
        try manager.createDirectory(at: url.deletingLastPathComponent(),
                           withIntermediateDirectories: true,
                           attributes: nil)
        return manager.createFile(atPath: url.path, contents: nil, attributes: nil)
    }

    public func delete() throws {
        try FileManager.default.removeItem(at: self.url)
    }

    public func copy(to destination: File, overwrite: Bool = false) throws {
        if !destination.folder.exists {
            try destination.folder.create()
        }
        if destination.exists && overwrite {
            try destination.delete()
        }
        try FileManager.default.copyItem(at: self.url, to: destination.url)
    }

    public func read() throws -> Data {
        return try Data(contentsOf: url)
    }
}
