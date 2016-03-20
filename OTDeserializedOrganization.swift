//
//  OTDeserializedOrganization.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 3/19/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedOrganization : OTDeserializer {
    
    public struct Keys {
        static let ORG_ID   = "id";
        static let NAME     = "name";
        static let LOGO_URL = "logo";
    }
    
    private var _orgID : OpenTimeOrgID;
    private var _name: String;
    private var _logoURL : String;
    
    public required init(dictionary: NSDictionary){
        self._orgID   = dictionary.objectForKey(Keys.ORG_ID) as! OpenTimeOrgID;
        self._name    = dictionary.objectForKey(Keys.NAME) as! String;
        self._logoURL = dictionary.objectForKey(Keys.LOGO_URL) as! String;
    }
    
    public func getOrgID() -> OpenTimeOrgID {
        return self._orgID;
    }
    
    public func getName() -> String {
        return self._name;
    }
    
    public func getLogoURL() -> String {
        return self._logoURL;
    }
    
}
