//
//  OpenTimeSDKTestConstant.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 10/25/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//
import UIKit

internal class OpenTimeSDKTestConstants {
    private init (){}
    
    private static let CONFIG_PATH: String  = {
        let bundle = NSBundle(forClass: OpenTimeSDKTestConstants().dynamicType);
        
        return bundle.pathForResource("Config", ofType: "plist") as String!;
    }();
    
    internal static let API_KEY: String = {
        let dictionary: NSDictionary! = NSDictionary(contentsOfFile: OpenTimeSDKTestConstants.CONFIG_PATH);
        
        return dictionary.objectForKey("OPENTIME_KEY") as! String;
    }();
}
