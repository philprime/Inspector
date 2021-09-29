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

    /// List of files located inside this folder
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

    /// List of folders located inside this folder
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

    /// Array of all files and folders located inside this folder
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

    /// Returns `true` if no folders and no files are located inside this folder
    public var isEmpty: Bool {
        content.isEmpty
    }

    public func recursiveCopy(to target: Folder) throws {
        if !target.exists {
            try target.create()
        }
        for file in files {
            try file.copy(to: File(name: file.name, extension: file.extension, in: target))
        }
        for folder in subfolders {
            try folder.recursiveCopy(to: target[subfolder: self.name])
        }
    }
}
