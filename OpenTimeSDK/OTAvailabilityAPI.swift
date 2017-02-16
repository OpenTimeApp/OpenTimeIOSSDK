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
    public static func getAllMyAvailability(_ done: @escaping (_ response: OTGetAllMyAvailabilityResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(1);
        
        _ = requestManager.get(OpenTimeSDK.getServer() + "/api/availability/all",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTGetAllMyAvailabilityResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTGetAllMyAvailabilityResponse(success: false, message: "", rawData: nil);
                    reply.makeEmpty();
                    done(reply);
                }
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTGetAllMyAvailabilityResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public static func removeOneTimeAvailability(_ availability: OTRemoveOneTimeAvailabilityData, done: @escaping (_ response: OTAPIResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        _ = requestManager.delete(OpenTimeSDK.getServer() + "/api/availability/oneTime/" + String(availability.getCreatedTimestamp()),
            parameters: availability.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response);
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: done);
            }
        );
    }
    
    public static func setOneTimeAvailability(_ availability: OTSetOneTimeAvailabilityData, done: @escaping (_ response: OTAPIResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        _ = requestManager.put(OpenTimeSDK.getServer() + "/api/availability/oneTime/" + String(availability.getCreatedTimestamp()),
            parameters: availability.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                requestManager.apiResult(operation, error: nil, done: done);
            },
            failure: { (operation: AFHTTPRequestOperation?,error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: done);
            }
        );
    }
    
    public static func getConnectionsAvailability(_ done: @escaping (_ response: OTGetConnectionsAvailabilityResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(0.5);
        
        _ = requestManager.get(OpenTimeSDK.getServer() + "/api/availability/forConnections",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTGetConnectionsAvailabilityResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTGetConnectionsAvailabilityResponse(success:false, message: "", rawData: nil);
                    reply.makeEmpty();
                    done(reply);
                }
            },
            failure: { (operation: AFHTTPRequestOperation?,error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTGetConnectionsAvailabilityResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );

    }
}
