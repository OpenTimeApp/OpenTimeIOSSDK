//
//  OTAPITest.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 3/19/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK

class OTAPITest : XCTestCase {
    
    override func setUp() {
        super.setUp()
        OpenTimeSDK.initSession(OpenTimeSDKTestConstants.API_KEY, inTestMode: true, passwordFixed: false);
        OpenTimeSDK.session.setPlainTextCredentials(1, password: "I love testing");
    }
    
}

