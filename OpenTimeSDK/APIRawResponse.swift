//
//  APIRawResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 5/10/15.
//  Copyright (c) 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit

public class APIRawResponse {
    
    // Whether or not the request logically succeeded or logically failed.
    // @SerializedName("success")
    private var _success: Bool;
    
    // The message associated with the success or failed response.
    // @SerializedName("message")
    private var _message: String;
    
    // String representation of data object.
    // @SerializedName("data")
    private var _rawData: AnyObject?;
    
    /**
        Designated constructor.
    */
    public init() {
        self._success = false;
        self._message = "Error: Message not parsed from server response";
    }
    
    /**
        Gets the success or failure from the response body from the server.
    
        - returns: Whether or not the request to the server succeeded.
    */
    public func isSuccessful() -> Bool {
        return self._success;
    }
    
    /**
        Gets the message about why the response failed or succeeded.
        
        - returns: A message explaining why the request to the server failed or succeeded.
    */
    public func getMessage() -> String {
        return self._message;
    }
    
    /**
        Gets a parsed object usually a dictionairy or an array.
    
        - returns: nil, an array of dictionaries, or a dictionary with data in it.
    */
    public func getRawData() -> AnyObject? {
        return self._rawData;
    }
    
    /**
        Tries to parse data elements from the first level of JSON elements.
        
        - parameter responseObject: The object given by AFNetworking by parsing a JSON string.
    
        - returns: A raw response object with the values of the first level of the JSON object.
    */
    public class func deserialize(responseObject: AnyObject!) -> APIRawResponse {
        
        // Setup the raw response object.
        let rawResponse: APIRawResponse = APIRawResponse();
        
        if(responseObject != nil)
        {
            
            // Try to get the success from the response object.
            if(OTSerialHelper.keyExists(responseObject, key: "success") == true) {
                rawResponse._success = responseObject.objectForKey("success") as! Bool;
            }
            
            // Try to get the message from the response object.
            if(OTSerialHelper.keyExists(responseObject, key: "message") == true) {
                rawResponse._message = responseObject.objectForKey("message") as! String;
            }
            
            // Try to get the data from the response object.
            if (rawResponse._success == true && OTSerialHelper.keyExists(responseObject, key: "data") == true) {
                rawResponse._rawData = self._getData(responseObject);
            }
        }
    
        if(responseObject != nil && rawResponse._success == false) {
            // Print the response object.
            print(responseObject, terminator: "");
        }
    
        return rawResponse;
    }
    
    /**
        Gets the data element from the response object.
    
        - returns: The data element of the response object.
    */
    private static func _getData(responseObject: AnyObject) -> AnyObject!
    {
        // Try to get the data object.
        let data: AnyObject! = responseObject["data"]!;
        
        // Set data property of the APIResponse as a typed object.
        if(data is NSDictionary)
        {
            // Its a dictionary. Cast it as a dictionary.
            return data as! NSDictionary;
        }else if(data is NSArray){
            // Its an array. Cast it as an array.
            return data as! NSArray;
        }else{
            // Its either empty or something besides an array or dictionary.
            return data;
        }
    }
}
