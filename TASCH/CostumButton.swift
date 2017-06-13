//
//  CostumButton.swift
//  TASCH
//
//  Created by My Computer on 2017-06-13.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class CostumButton: UIButton {

    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 6.0
    }

}
