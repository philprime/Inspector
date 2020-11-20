//
//  Inspector.swift
//  Inspector
//
//  Created by Philip Niedertscheider on 29.06.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
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
}
