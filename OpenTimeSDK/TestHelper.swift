//
//  TestHelper.swift
//  OpenTime
//
//  Created by Josh Woodcock on 5/17/15.
//  Copyright (c) 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

public struct TestHelper {
    
    public static func resetAPIData(scriptNames: Array<String>, done: (response: APIResponse)->Void, clearCache: Bool) {
        
        let scripts           = scriptNames.joinWithSeparator(",");
        let clearCacheCommand = clearCache == true ? "YES" : "NO";
        
        let parameters = [
            "script":scripts,
            "clear_cache":clearCacheCommand,
            "api_key":OpenTimeSDK.getKey()
        ];
        
        let manager = AFHTTPRequestOperationManager();
        
        manager.GET(OpenTimeSDK.getServer() + "/tests/data_restore.php", parameters: parameters,
            success: { (operation: AFHTTPRequestOperation, responseObject: AnyObject) -> Void in
                let success = responseObject.valueForKey("success") as! Bool;
                let message = responseObject.valueForKey("message") as! String;
                
                done(response: APIResponse(success: success, message: message));
            }, failure:{ (operation: AFHTTPRequestOperation, error: NSError?) -> Void in
                done(response: APIResponse(success: false, message: error!.description));
            }
        );
    }
}
