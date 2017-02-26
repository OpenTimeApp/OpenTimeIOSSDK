//
//  DeviceAPI.swift
//  OpenTime
//
//  Created by Josh Woodcock on 4/21/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTDeviceAPI
{
    public static func set(_ key: String, done: @escaping (_ response: OTAPIResponse)->Void)
    {
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        _ = requestManager.put(OpenTimeSDK.getServer() + "/api/device/ios/" + key,
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                requestManager.apiResult(operation, error: nil, done: done);
            },
            failure: { (operation: AFHTTPRequestOperation?,error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: done);
            }
        );
    }
}
