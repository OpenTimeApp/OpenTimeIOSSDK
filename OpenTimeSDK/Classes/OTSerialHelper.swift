//
//  SerialHelper.swift
//  OpenTime
//
//  Created by Josh Woodcock on 5/16/15.
//  Copyright (c) 2015 Connecting Open Time, LLC. All rights reserved.
//

public struct OTSerialHelper {
    
    /**
    Safely tests if a key value exists in the given object.
    
        - parameter responseObject: The raw response object from AFNetworking library.
        - parameter key: The key value being evaluated for existance.
    
        - returns: Bool Whether or not the key exists in the response object.
    */
    public static func keyExists(_ object: AnyObject!, key: String) -> Bool{
        let keyExists = object.value(forKey: key) != nil;
        return keyExists;
    }
    
    public static func decodeJSONString(_ jsonString: String) -> NSDictionary {
        
        // Convert JSON string to a parsable data object.
        let jsonData: Data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: true)!;

        // Parse the JSON string into a dictionary.
        let parsedData: NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary;
        
        return parsedData;
    }
    
    public static func dataArrayToArray(_ dataArray: NSArray) -> Array<AnyObject> {
        
        var anyObjectArray = Array<AnyObject>();
        
        for index in 0 ..< dataArray.count {
            let dataItem: AnyObject = dataArray.object(at: index) as AnyObject;
            
            anyObjectArray.append(dataItem);
        }
        
        return anyObjectArray;
    }
    
    public static func dataArrayToArrayOfStrings(_ dataArray: NSArray) -> Array<String> {
        
        var strings = Array<String>();
        
        for index in 0 ..< dataArray.count {
            let dataItem: AnyObject! = dataArray.object(at: index) as AnyObject!;
            if(dataItem != nil && (dataItem is String || dataItem is NSString)){
                strings.append(dataItem as! String);
            }
        }
        
        return strings;
    }
}
