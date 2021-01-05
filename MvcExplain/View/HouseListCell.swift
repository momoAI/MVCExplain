//
//  HouseListCell.swift
//  MvcExplain
//
//  Created by luxury on 2020/12/13.
//  Copyright © 2020 luxury. All rights reserved.
//

import UIKit

class HouseListCell: UITableViewCell {
    var houseItem: HouseItem? {
        didSet {
            textLabel?.text = houseItem?.info
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
