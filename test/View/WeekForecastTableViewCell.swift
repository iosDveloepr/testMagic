//
//  WeekForecastTableViewCell.swift
//  test
//
//  Created by Anton Yermakov on 31.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import UIKit

class WeekForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
