//
//  HouseDetailViewController.swift
//  MvcExplain
//
//  Created by luxury on 2020/12/13.
//  Copyright © 2020 luxury. All rights reserved.
//

import UIKit

protocol HouseDetailVcDelegate: class {
    func houseDetailVc(_ vc: HouseDetailViewController, delete pkHouse: UUID)
}

class HouseDetailViewController: UIViewController {
    weak var delegate: HouseDetailVcDelegate?
    
    public var pkHouse: UUID!
    
    public var item: HouseItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deleteHouse(_:)))
    }
    

    
    @objc func deleteHouse(_ sender: Any) {
//        self.delegate?.houseDetailVc(self, delete: pkHouse)
//        self.navigationController?.popViewController(animated: true)
        
        HouseStore.shared.remove(item: item)
        self.navigationController?.popViewController(animated: true)
    }
    

}
