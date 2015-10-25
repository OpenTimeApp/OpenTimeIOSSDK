//
//  SerialHelper.swift
//  OpenTime
//
//  Created by Josh Woodcock on 5/16/15.
//  Copyright (c) 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit

public struct SerialHelper {
    
    /**
    Safely tests if a key value exists in the given object.
    
        - parameter responseObject: The raw response object from AFNetworking library.
        - parameter key: The key value being evaluated for existance.
    
        - returns: Bool Whether or not the key exists in the response object.
    */
    public static func keyExists(object: AnyObject!, key: String) -> Bool{
        let keyExists = object.valueForKey(key) != nil;
        return keyExists;
    }
    
    public static func decodeJSONString(jsonString: String) -> NSDictionary {
        
        // Convert JSON string to a parsable data object.
        let jsonData: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!;

        // Parse the JSON string into a dictionary.
        let parsedData: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary;
        
        return parsedData;
    }
    
    public static func dataArrayToArray(dataArray: NSArray) -> Array<AnyObject> {
        
        var anyObjectArray = Array<AnyObject>();
        
        for var index = 0; index < dataArray.count; index++ {
            let dataItem: AnyObject = dataArray.objectAtIndex(index);
            
            anyObjectArray.append(dataItem);
        }
        
        return anyObjectArray;
    }
    
    public static func dataArrayToArrayOfStrings(dataArray: NSArray) -> Array<String> {
        
        var strings = Array<String>();
        
        for var index = 0; index < dataArray.count; index++ {
            let dataItem: AnyObject! = dataArray.objectAtIndex(index);
            if(dataItem != nil && (dataItem is String || dataItem is NSString)){
                strings.append(dataItem as! String);
            }
        }
        
        return strings;
    }
}
