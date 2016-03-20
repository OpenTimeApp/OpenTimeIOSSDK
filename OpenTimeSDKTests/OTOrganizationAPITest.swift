//
//  OTOrganizationAPITest.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 3/19/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK

class OTOrganizationAPITest : OTAPITest {
    
    func testMyOrganizations() {
        
        let response: OTAPIResponse = TestHelper.getDataResetResponse(self, scriptNames: ["make_users"], resetCache: true);

        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);

        if(response.success) {

            // Create an expectation to be fulfilled.
            let expectation = expectationWithDescription("Get my organizations");
            
            OTOrganizationAPI.getMyOrganizations({ (response: OTGetMyOrganizationsResponse) -> Void in
                
                XCTAssertTrue(response.success);
                XCTAssertEqual(1, response.getOrganizations().count);
                if(response.success && response.getOrganizations().count == 1){
                    let organizations = response.getOrganizations();
                    
                    let organization = organizations[0] as OTDeserializedOrganization;
                    
                    XCTAssertEqual(1, organization.getOrgID());
                    XCTAssertEqual("OpenTime", organization.getName());
                    XCTAssertEqual("http://app.opentimeapp.com/img/logo/icon-transparent-filled.png", organization.getLogoURL());
                }

                expectation.fulfill();
            });
        
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }
    
}
