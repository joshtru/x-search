//
//  CardView.swift
//  X-Search
//
//  Created by Joshua Okoro on 1/22/19.
//  Copyright © 2019 Joshua Okoro. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffSetWidth: CGFloat = 0
    @IBInspectable var shadowOffSetHeight: CGFloat = 5
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpacity: CGFloat = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }

}
