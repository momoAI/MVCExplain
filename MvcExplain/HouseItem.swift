//
//  File.swift
//  MvcExplain
//
//  Created by luxury on 2020/12/13.
//  Copyright © 2020 luxury. All rights reserved.
//

import Foundation

struct HouseItem {
    let pkHouse = UUID()
    var info: String {
        get {
            return "house--" + pkHouse.uuidString
        }
    }
}

extension HouseItem: Hashable {
    public static func == (lhs: HouseItem, rhs: HouseItem) -> Bool {
        return lhs.pkHouse == rhs.pkHouse
    }
}

//extension HouseItem: Hashable {
//    
//}
