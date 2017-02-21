//
//  OTGetAllMyMeetingsResponse.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTGetAllMyMeetingsResponse : OTAPIResponse {
    
    private var _meetings: Array<OTDeserializedMeeting>;
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        
        if(rawData != nil){
            self._meetings = OTDeserializationHelper.deserializeList(rawData as! NSArray, type: OTDeserializedMeeting.self) as! Array<OTDeserializedMeeting>;
        }else{
            self._meetings = Array<OTDeserializedMeeting>()
        }
        
        super.init(success: success, message: message);
    }
    
    public func getMeetings() -> Array<OTDeserializedMeeting> {
        return _meetings;
    }
}
