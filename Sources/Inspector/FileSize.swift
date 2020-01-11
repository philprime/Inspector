//
//  FileSize.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 11.01.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
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
    var KiB: Int64 {
        bytes / 1024
    }

    /// Mebibyte
    var MiB: Int64 {
        KiB / 1024
    }

    /// Gibibyte
    var GiB: Int64 {
        MiB / 1024
    }

    /// Tebibyte
    var TiB: Int64 {
        GiB / 1024
    }

    /// Pebibyte
    var PiB: Int64 {
        TiB / 1024
    }

    /// Exbibyte
    var EiB: Int64 {
        PiB / 1024
    }

    /// Zebibyte
    var ZiB: Int64 {
        MiB / 1024
    }

    /// Yobibyte
    var YiB: Int64 {
        ZiB / 1024
    }

    // MARK: - Binary prefix

    /// Kilobyte
    var kB: Int64 {
        bytes / 1000
    }

    /// Megabyte
    var MB: Int64 {
        kB / 1000
    }

    /// Gigabyte
    var GB: Int64 {
        MB / 1000
    }

    /// Terabyte
    var TB: Int64 {
        GB / 1000
    }

    /// Petabyte
    var PB: Int64 {
        TB / 1000
    }

    /// Exabyte
    var EB: Int64 {
        PB / 1000
    }

    /// Zettabyte
    var ZB: Int64 {
        EB / 1000
    }

    /// Yottabyte
    var YB: Int64 {
        ZB / 1000
    }
}
