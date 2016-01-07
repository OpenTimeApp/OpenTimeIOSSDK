//
//  OTMeetingAttendeeAPI.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTMeetingAttendeeAPI {
    
    public static func set(data: OTSetMeetingAttendeeData, done: (response: OTSetMeetingAttendeeResponse)->Void) {
        // Setup request manager.
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        let url = OpenTimeSDK.getServer() + "/api/meeting/" + String(data.getMeetingID()) + "/attendee/" + String(data.getAttendeeUserID());
        
        requestManager.PUT(url,
            parameters: data.getParameters(),
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
        
                done(response: OTSetMeetingAttendeeResponse(success: response.success, message: response.message));
                
            },failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTSetMeetingAttendeeResponse(success: response.success, message: response.message));
                });
            }
        );
    }
    
}
