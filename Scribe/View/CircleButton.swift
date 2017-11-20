//
//  CircleButton.swift
//  Scribe
//
//  Created by Jibran Syed on 10/29/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

//@IBDesignable
class CircleButton: UIButton 
{
    @IBInspectable var cornerRadius: CGFloat = 30.0
    {
        didSet
        {
            self.setupView()
        }
    }
    
    
    override func prepareForInterfaceBuilder() 
    {
        self.setupView()
    }
    
    
    func setupView()
    {
        layer.cornerRadius = self.cornerRadius
    }
    
}
