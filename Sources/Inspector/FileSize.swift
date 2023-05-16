//
//  FileSize.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright (c) 2023 Philip Niedertscheider. All rights reserved.
//

public class FileSize {

    public let bytes: Int64

    init(bytes: Int64) {
        self.bytes = bytes
    }

    static var empty: FileSize {
        FileSize(bytes: 0)
    }

    // MARK: - Decimal prefix

    /// Kibibyte
    public var KiB: Int64 {
        bytes / 1024
    }

    /// Mebibyte
    public var MiB: Int64 {
        KiB / 1024
    }

    /// Gibibyte
    public var GiB: Int64 {
        MiB / 1024
    }

    /// Tebibyte
    public var TiB: Int64 {
        GiB / 1024
    }

    /// Pebibyte
    public var PiB: Int64 {
        TiB / 1024
    }

    /// Exbibyte
    public var EiB: Int64 {
        PiB / 1024
    }

    /// Zebibyte
    public var ZiB: Int64 {
        MiB / 1024
    }

    /// Yobibyte
    public var YiB: Int64 {
        ZiB / 1024
    }

    // MARK: - Binary prefix

    /// Kilobyte
    public var kB: Int64 {
        bytes / 1000
    }

    /// Megabyte
    public var MB: Int64 {
        kB / 1000
    }

    /// Gigabyte
    public var GB: Int64 {
        MB / 1000
    }

    /// Terabyte
    public var TB: Int64 {
        GB / 1000
    }

    /// Petabyte
    public var PB: Int64 {
        TB / 1000
    }

    /// Exabyte
    public var EB: Int64 {
        PB / 1000
    }

    /// Zettabyte
    public var ZB: Int64 {
        EB / 1000
    }

    /// Yottabyte
    public var YB: Int64 {
        ZB / 1000
    }
}
