//
//  ReachabilityHelper.swift
//  OpenTime
//
//  Created by Josh Woodcock on 6/29/15.
//  Copyright (c) 2015 Be Agile, LLC. All rights reserved.
//

import UIKit
import AFNetworking

public class Reachability {
    
    private static var _didTestNetworkConnection: Bool = false;
    
    public static func shouldForceCacheUse() -> Bool {
        return self._didTestNetworkConnection;
    }
    
    public static func beginNetworkMonitoring() {
        AFNetworkReachabilityManager.sharedManager().startMonitoring();
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)){
            // Give teh ReachabilityManager at least 5 seconds to identify whether or not there is a network connection.
            NSThread.sleepForTimeInterval(5.0);
            self._didTestNetworkConnection = true;
        }
    }
}
