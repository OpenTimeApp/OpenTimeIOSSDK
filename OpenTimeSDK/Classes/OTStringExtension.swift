//
//  StringExtension.swift
//  OpenTime
//
//  Created by Josh Woodcock on 2/25/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import SCrypto

public extension String {
    public func md5Fixed() -> String {
        return self.MD5()
    }
}
