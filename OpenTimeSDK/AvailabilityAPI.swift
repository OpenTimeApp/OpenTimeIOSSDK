//
//  AvailabilityAPI.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/23/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

public class AvailabilityAPI: NSObject
{
    public class func getAllMyAvailability(done: (response: GetAllMyAvailabilityResponse)->Void)
    {
        let requestManager = APIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(1);
        
        requestManager.GET(OpenTimeSDK.getServer() + "/api/availability/all",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = APIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: GetAllMyAvailabilityResponse(success: response.success, message: response.message, rawData: response.rawData));
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                requestManager.apiResult(operation, error: error, done: {(response: APIResponse)->Void in
                    done(response: GetAllMyAvailabilityResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public class func removeOneTimeAvailability(availability: RemoveOneTimeAvailabilityData, done: (response: APIResponse)->Void)
    {
        let requestManager = APIAuthorizedRequestOperationManager();
        
        requestManager.DELETE(OpenTimeSDK.getServer() + "/api/availability/oneTime/" + String(availability.getCreatedTimestamp()),
            parameters: availability.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = APIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: response);
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                requestManager.apiResult(operation, error: error, done: done);
            }
        );
    }
    
    public class func setOneTimeAvailability(availability: SetOneTimeAvailabilityData, done: (response: APIResponse)->Void)
    {
        let requestManager = APIAuthorizedRequestOperationManager();
        
        requestManager.PUT(OpenTimeSDK.getServer() + "/api/availability/oneTime/" + String(availability.getCreatedTimestamp()),
            parameters: availability.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                requestManager.apiResult(operation, error: nil, done: done);
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                requestManager.apiResult(operation, error: error, done: done);
            }
        );
    }
    
    public class func getConnectionsAvailability(currentUserID: OpenTimeUserID, done: (response: GetConnectionsAvailabilityResponse)->Void)
    {
        let requestManager = APIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(0.5);
        
        requestManager.GET(OpenTimeSDK.getServer() + "/api/availability/forConnections",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = APIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: GetConnectionsAvailabilityResponse(success: response.success, message: response.message, rawData: response.rawData));
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                requestManager.apiResult(operation, error: error, done: {(response: APIResponse)->Void in
                    done(response: GetConnectionsAvailabilityResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );

    }
}
