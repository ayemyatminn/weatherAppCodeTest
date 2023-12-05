//
//  CardView.swift
//  Weather
//
//  Created by Aye Myat Minn on 05/12/2023.
//

import Foundation
import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 8
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var borderColor: UIColor? = UIColor.clear
    @IBInspectable var borderWidth: Float = 0.0
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = CGFloat.init(borderWidth)

    }
    
    func decorateCardViewToolbar(){
        
    }
    
}
