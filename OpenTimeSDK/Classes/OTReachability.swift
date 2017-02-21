//
//  ReachabilityHelper.swift
//  OpenTime
//
//  Created by Josh Woodcock on 6/29/15.
//  Copyright (c) 2015 Be Agile, LLC. All rights reserved.
//

import AFNetworking

public class OTReachability {
    
    private static var _didTestNetworkConnection: Bool = false;
    
    public static func shouldForceCacheUse() -> Bool {
        return self._didTestNetworkConnection;
    }
    
    public static func beginNetworkMonitoring() {
        AFNetworkReachabilityManager.shared().startMonitoring();
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async{
            // Give teh ReachabilityManager at least 5 seconds to identify whether or not there is a network connection.
            Thread.sleep(forTimeInterval: 5.0);
            self._didTestNetworkConnection = true;
        }
    }
}
