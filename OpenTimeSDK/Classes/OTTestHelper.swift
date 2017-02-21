//
//  TestHelper.swift
//  OpenTime
//
//  Created by Josh Woodcock on 5/17/15.
//  Copyright (c) 2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public struct OTTestHelper {
    
    public static func resetAPIData(_ scriptNames: Array<String>, done: @escaping (_ response: OTAPIResponse)->Void, clearCache: Bool) {
        
        let scripts           = scriptNames.joined(separator: ",");
        let clearCacheCommand = clearCache == true ? "YES" : "NO";
        
        let parameters = [
            "script":scripts,
            "clear_cache":clearCacheCommand,
            "api_key":OpenTimeSDK.getKey()
        ];
        
        let manager = AFHTTPRequestOperationManager();
        
        manager.get(OpenTimeSDK.getServer() + "/restore/restore.php", parameters: parameters,
            success: { (operation: AFHTTPRequestOperation, responseObject: Any) -> Void in
                let success = (responseObject as AnyObject).value(forKey: "success") as! Bool;
                let message = (responseObject as AnyObject).value(forKey: "message") as! String;
                
                done(OTAPIResponse(success: success, message: message));
            }, failure:{ (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                done(OTAPIResponse(success: false, message: error.localizedDescription));
            }
        );
    }
}
