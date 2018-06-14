//
//  Urilities.swift
//  test
//
//  Created by Anton Yermakov on 01.06.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    class func alertError(withMessage message: String, vc: UIViewController){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
}
