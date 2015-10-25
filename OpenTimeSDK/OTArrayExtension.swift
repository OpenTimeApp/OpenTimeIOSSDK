//
//  ArrayExtension.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 10/24/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

extension Array {
    func has<T : Equatable>(obj: T) -> Bool {
        let filtered = self.filter {$0 as? T == obj}
        return filtered.count > 0
    }
}
