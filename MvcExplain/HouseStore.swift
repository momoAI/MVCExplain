//
//  HouseStore.swift
//  MvcExplain
//
//  Created by luxury on 2020/12/13.
//  Copyright © 2020 luxury. All rights reserved.
//

import Foundation


class HouseStore {
    enum ChangeBehavior {
        case add([Int])
        case remove([Int])
        case reload
    }
    
    static let shared = HouseStore()
    
    private var items: [HouseItem] = [] {
        didSet {
            let behavior = getBehavior(olds: oldValue, news: items)
            NotificationCenter.default.post(name: NSNotification.Name("houseChange"), object: ["behavior" : behavior])
        }
    }
    
    private init() {
        
        
    }
    
    func append(item: HouseItem) {
        items.append(item)
    }
    
    func append(newItems: [HouseItem]) {
        items.append(contentsOf: newItems)
    }
    
    func remove(item: HouseItem) {
        guard let index = items.firstIndex(of: item) else { return }
        remove(at: index)
    }
    
    func remove(at index: Int) {
        items.remove(at: index)
    }
    
    var count: Int {
        return items.count
    }
    
    func item(at index: Int) -> HouseItem {
        return items[index]
    }
    
    func getBehavior(olds: [HouseItem], news: [HouseItem]) -> ChangeBehavior {
        let oldset = Set(olds)
        let newset = Set(news)
        
        if oldset.isSubset(of: newset) { // add
            let added = newset.subtracting(oldset)
            let indexs = added.compactMap{ news.firstIndex(of: $0) }
            return .add(indexs)
        } else if oldset.isSuperset(of: newset) { // delete
            let removed = oldset.subtracting(newset)
            let indexs = removed.compactMap{ olds.firstIndex(of: $0) }
            return .remove(indexs)
        } else { // edit
            return .reload
        }
    }
}
