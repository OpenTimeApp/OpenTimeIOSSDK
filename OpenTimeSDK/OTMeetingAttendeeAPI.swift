//
//  OTMeetingAttendeeAPI.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTMeetingAttendeeAPI {
    
    public static func set(_ data: OTSetMeetingAttendeeData, done: @escaping (_ response: OTSetMeetingAttendeeResponse)->Void) {
        // Setup request manager.
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        let url = OpenTimeSDK.getServer() + "/api/meeting/" + String(data.getMeetingID()) + "/attendee/" + String(data.getAttendeeUserID());
        
        _ = requestManager.put(url,
            parameters: data.getParameters(),
            success: {(operation: AFHTTPRequestOperation!, responseObject: Any) -> Void in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
        
                done(OTSetMeetingAttendeeResponse(success: response.success, message: response.message));
                
            },failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTSetMeetingAttendeeResponse(success: response.success, message: response.message));
                });
            }
        );
    }
    
}
