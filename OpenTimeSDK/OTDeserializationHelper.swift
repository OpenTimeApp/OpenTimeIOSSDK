//
//  OTDeserializationHelper.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 3/19/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

internal class OTDeserializationHelper {
    
    internal static func deserializeList(_ rawData: NSArray, type: OTDeserializer.Type ) -> NSArray {
        
        let list: NSMutableArray = NSMutableArray();
        
        for attendeeIndex in 0 ..< rawData.count {
            
            let rawAttendeeData = rawData.object(at: attendeeIndex) as! NSDictionary;
            
            let deserializer = type.init(dictionary: rawAttendeeData);
            
            list.add(deserializer as AnyObject);
        }
    
        return list as NSArray;
    }
    
}
