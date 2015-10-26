//
//  OTAPIAuthorizedRequestOperationManager.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/10/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

public class OTAPIAuthorizedRequestOperationManager: OTAPIRequestOperationManager {
    
    public override func setupHeaders() {
        super.setupHeaders();
        
        let userID: Int! = OpenTimeSDK.session.getUserID();
        if(userID != nil) {
            self.requestSerializer.setValue(String(userID), forHTTPHeaderField: "User-Id");
            self.requestSerializer.setValue(OpenTimeSDK.session.getEncryptedPassword(), forHTTPHeaderField: "Password");
        }
    }
}
