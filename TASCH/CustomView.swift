//
//  CustomView.swift
//  E-SHOP
//
//  Created by My Computer on 2017-06-13.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
        override func awakeFromNib() {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 6.0
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 3.0
            self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
        }
        
    }
    
    // https://stackoverflow.com/questions/25616382/how-to-set-cornerradius-for-only-bottom-left-bottom-right-and-top-left-corner-of
    extension UIView {
        func roundCorners(corners:UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }


