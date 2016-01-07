//
//  DeviceAPI.swift
//  OpenTime
//
//  Created by Josh Woodcock on 4/21/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

public struct OTDeviceAPI
{
    public static func set(key: String, done: (response: OTAPIResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.PUT(OpenTimeSDK.getServer() + "/api/device/ios/" + key,
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                requestManager.apiResult(operation, error: nil, done: done);
            },
            failure: { (operation: AFHTTPRequestOperation?,error: NSError) in
                requestManager.apiResult(operation, error: error, done: done);
            }
        );
    }
}
