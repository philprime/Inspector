//
//  File.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import Foundation

public class File {

    public let url: URL

    convenience init(path: String) {
        self.init(url: URL(fileURLWithPath: path))
    }

    convenience init(name: String, extension ext: String? = nil, in folder: Folder) {
        var path = folder.url.appendingPathComponent(name)
        if let ext = ext {
            path.appendPathExtension(ext)
        }
        self.init(url: path)
    }

    init(url: URL) {
        self.url = url
    }

    var exists: Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }

    var size: FileSize {
        guard let fileSizeResourceValue = try? url.resourceValues(forKeys: [.isDirectoryKey, .fileSizeKey]) else {
            return .empty
        }
        if fileSizeResourceValue.isDirectory == true {
            return .empty
        }
        return FileSize(bytes: Int64(fileSizeResourceValue.fileSize ?? 0))
    }

    @discardableResult
    func touch() -> Bool {
        return FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
    }
}
