//
//  OTDeserializedLocation.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedLocation : OTDeserializer {
    
    private struct Keys {
        static let LATITUDE  = "lat";
        static let LONGITUDE = "long";
        static let ADDRESS   = "address";
    }
    
    private var _latitude: Double;
    private var _longitude: Double;
    private var _address: String;
    
    public required init(dictionary: NSDictionary){
        self._latitude  = dictionary.valueForKey(Keys.LATITUDE) as! Double;
        self._longitude = dictionary.valueForKey(Keys.LONGITUDE) as! Double;
        self._address   = dictionary.valueForKey(Keys.ADDRESS) as! String;
    }
    
    public func getLatitude() -> Double {
        return self._latitude;
    }
    
    public func getLongitude() -> Double {
        return self._longitude;
    }
    
    public func getAddress() -> String {
        return self._address;
    }
}
