//
//  GetConnectionsWithContactInfoData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class GetConnectionsWithContactInfoData {
    
    private var _connections: Array<ContactInfoData>;
    private var _contactsAlreadyInOpenTime: Array<ContactInfoData>;
    
    public init(connections: Array<ContactInfoData>, contactsAlreadyInOpenTime: Array<ContactInfoData>) {
        self._connections               = connections;
        self._contactsAlreadyInOpenTime = contactsAlreadyInOpenTime;
    }
    
    public func getParameters() -> NSDictionary {
        
        var emails = Array<String>();
        var phones = Array<String>();
        
        emails = self._getEmails(self._connections, appendToList: emails);
        emails = self._getEmails(self._contactsAlreadyInOpenTime, appendToList: emails);
        
        phones = self._getCellPhones(self._connections, appendToList: phones)
        phones = self._getCellPhones(self._connections, appendToList: phones)
        
        let data = [
            "emails" : emails,
            "cell_phones" : phones
        ];
        
        return data;
    }
    
    private func _getEmails(list: Array<ContactInfoData>, var appendToList: Array<String>) -> Array<String> {
        
        for contact in list {
            let contactEmails = contact.getEmails();
            for email in contactEmails {
                if(appendToList.contains(email) == false) {
                    appendToList.append(email);
                }
            }
        }
        return appendToList;
    }
    
    private func _getCellPhones(list: Array<ContactInfoData>, var appendToList: Array<String>) -> Array<String>{

        for contact in list {
            let contactPhones = contact.getCellPhones()
            for phone in contactPhones {
                if(list.contains(phone) == false) {
                    appendToList.append(phone);
                }
            }
        }
        return appendToList;
    }
}
