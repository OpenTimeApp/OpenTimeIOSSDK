//
//  OTCreateMeetingResponse.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTCreateMeetingResponse : OTAPIResponse {
    
    private var _meetingData: OTDeserializedCreateMeetingResponseData?;
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        super.init(success: success, message: message);
        
        if(rawData != nil){
            _meetingData = OTDeserializedCreateMeetingResponseData(dictionary: rawData! as! NSDictionary);
        }
    }
    
    public func getMeetingData() -> OTDeserializedCreateMeetingResponseData? {
        return self._meetingData!;
    }
}
