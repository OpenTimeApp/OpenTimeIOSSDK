//
//  StringExtension.swift
//  OpenTime
//
//  Created by Josh Woodcock on 2/25/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    public func md5() -> String {
        let data = (self as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))
        let resultBytes = UnsafeMutablePointer<CUnsignedChar>(result!.mutableBytes)
        CC_MD5(data!.bytes, CC_LONG(data!.length), resultBytes)
        
        let buff = UnsafeBufferPointer<CUnsignedChar>(start: resultBytes, count: result!.length)
        let hash = NSMutableString()
        for i in buff {
            hash.appendFormat("%2x", i)
        }
        
        let withWhiteSpace: NSString = hash as NSString;
        let final = withWhiteSpace.stringByReplacingOccurrencesOfString(" ", withString: "");
        return final as String;
    }

}
