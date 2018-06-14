//
//  MainTableViewCell.swift
//  test
//
//  Created by Anton Yermakov on 30.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
