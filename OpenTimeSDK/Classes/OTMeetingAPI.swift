//
//  OTMeetingAPI.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTMeetingAPI {
    
    public static func create(createMeetingData: OTCreateMeetingData, done: @escaping (_ response: OTCreateMeetingResponse)->Void) -> Void {
        
        // Setup request manager.
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        _ = requestManager.post(OpenTimeSDK.getServer() + "/api/meeting",
            parameters: createMeetingData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) -> Void in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTCreateMeetingResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTCreateMeetingResponse(success: false, message: "", rawData: nil);
                    reply.makeEmpty();
                    done(reply);
                }
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTCreateMeetingResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public static func getAllMyMeetings(done: @escaping (_ response: OTGetAllMyMeetingsResponse)->Void) {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        _ = requestManager.get(OpenTimeSDK.getServer() + "/api/meeting/all",
            parameters: [],
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) -> Void in
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTGetAllMyMeetingsResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTGetAllMyMeetingsResponse(success: false, message: "", rawData: nil);
                    reply.makeEmpty();
                    done(reply);
                }
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTGetAllMyMeetingsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        )
    }
    
}
