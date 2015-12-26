//
//  AvailabilityAPI.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/23/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

public class OTAvailabilityAPI: NSObject
{
    public class func getAllMyAvailability(done: (response: OTGetAllMyAvailabilityResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(1);
        
        requestManager.GET(OpenTimeSDK.getServer() + "/api/availability/all",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: OTGetAllMyAvailabilityResponse(success: response.success, message: response.message, rawData: response.rawData));
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTGetAllMyAvailabilityResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public class func removeOneTimeAvailability(availability: OTRemoveOneTimeAvailabilityData, done: (response: OTAPIResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.DELETE(OpenTimeSDK.getServer() + "/api/availability/oneTime/" + String(availability.getCreatedTimestamp()),
            parameters: availability.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: response);
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                requestManager.apiResult(operation, error: error, done: done);
            }
        );
    }
    
    public class func setOneTimeAvailability(availability: OTSetOneTimeAvailabilityData, done: (response: OTAPIResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
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
    
    public class func getConnectionsAvailability(done: (response: OTGetConnectionsAvailabilityResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(0.5);
        
        requestManager.GET(OpenTimeSDK.getServer() + "/api/availability/forConnections",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: OTGetConnectionsAvailabilityResponse(success: response.success, message: response.message, rawData: response.rawData));
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTGetConnectionsAvailabilityResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );

    }
}
