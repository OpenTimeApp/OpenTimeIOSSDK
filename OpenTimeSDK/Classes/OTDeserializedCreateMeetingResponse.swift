//
//  OTCreateMeetingResponseData.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedCreateMeetingResponseData : OTDeserializer{
    
    private struct Keys {
        static let MEETING_ID = "id";
    }
    
    private var _meetingID: Int;
    
    public required init(dictionary: NSDictionary){
        self._meetingID = dictionary.value(forKey: Keys.MEETING_ID) as! Int;
    }
    
    public func getMeetingID() -> Int {
        return self._meetingID;
    }
}
