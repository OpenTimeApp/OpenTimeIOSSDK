//
//  OTCreateMeetingResponseData.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedCreateMeetingResponse {
    
    private var _meetingID: Int;
    
    public init(dictionary: NSDictionary){
        self._meetingID = dictionary.valueForKey("id") as! Int;
    }
    
    public func getMeetingID() -> Int {
        return self._meetingID;
    }
}
