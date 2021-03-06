//
//  Folder.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import Foundation

public class Folder: FSItem {

    public convenience init(name: String, in folder: Folder) {
        self.init(url: folder.url.appendingPathComponent(name))
    }

    public override init(url: URL) {
        super.init(url: url)
    }

    public var exists: Bool {
        var isDirectory: ObjCBool = false
        return FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue
    }

    public var files: [File] {
        do {
            return try getContentURLs(of: url)
                .compactMap({ (url, isDirectory) in
                    isDirectory ? nil : File(url: url)
                })
        } catch {
            return []
        }
    }

    public var subfolders: [Folder] {
        do {
            return try getContentURLs(of: url)
                .compactMap({ (url, isDirectory) in
                    isDirectory ? Folder(url: url) : nil
                })
        } catch {
            return []
        }
    }

    public var content: [FSItem] {
        do {
            return try getContentURLs(of: url)
                .map({ (url, isDirectory) in
                    isDirectory ? Folder(url: url) : File(url: url)
                })
        } catch {
            return []
        }
    }

    private func getContentURLs(of url: URL) throws -> [(url: URL, isDirectory: Bool)] {
        var resolvedURL = url
        resolvedURL.resolveSymlinksInPath()

        return try FileManager
            .default
            .contentsOfDirectory(at: resolvedURL, includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey])
            .map({ (url: $0, isDirectory: isDirectory(url: $0)) })
    }

    private func isDirectory(url: URL) -> Bool {
        (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true
    }

    public var size: FileSize {
        (files.map({ $0.size }) + subfolders.map({ $0.size })).reduce(FileSize.empty, +)
    }

    public func create() throws {
        try FileManager.default.createDirectory(at: self.url, withIntermediateDirectories: true, attributes: nil)
    }

    public func remove() throws {
        try FileManager.default.removeItem(at: self.url)
    }

    public func clear() throws {
        guard exists else {
            return
        }
        for item in try getContentURLs(of: self.url) {
            try FileManager.default.removeItem(at: item.url)
        }
    }

    public subscript(subfolder path: String) -> Folder {
        Folder(url: self.url.appendingPathComponent(path))
    }

    public subscript(file path: String) -> File {
        File(url: self.url.appendingPathComponent(path))
    }

    public var parent: Folder {
        Folder(url: self.url.deletingLastPathComponent())
    }
}
