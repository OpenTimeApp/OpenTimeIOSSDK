//
//  OTMeetingAPI.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTMeetingAPI {
    
    public static func create(createMeetingData: OTCreateMeetingData, done: (response: OTCreateMeetingResponse)->Void) {
        
        // Setup request manager.
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.POST(OpenTimeSDK.getServer() + "/api/meeting",
            parameters: createMeetingData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: OTCreateMeetingResponse(success: response.success, message: response.message, rawData: response.rawData!));
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTCreateMeetingResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public static func getAllMyMeetings(done: (response: OTGetAllMyMeetingsResponse)->Void) {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.GET(OpenTimeSDK.getServer() + "/api/meeting/all",
            parameters: [],
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                done(response: OTGetAllMyMeetingsResponse(success: response.success, message: response.message, rawData: response.rawData!));
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTGetAllMyMeetingsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        )
    }
    
}
