//
//  OTDeserializationHelper.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 3/19/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

internal class OTDeserializationHelper {
    
    internal static func deserializeList(rawData: NSArray, type: OTDeserializer.Type ) -> NSArray {
        
        let list: NSMutableArray = NSMutableArray();
        
        for var attendeeIndex = 0; attendeeIndex < rawData.count; attendeeIndex++ {
            
            let rawAttendeeData = rawData.objectAtIndex(attendeeIndex) as! NSDictionary;
            
            let deserializer = type.init(dictionary: rawAttendeeData);
            
            list.addObject(deserializer as! AnyObject);
        }
    
        return list as NSArray;
    }
    
}
