//
//  AvatarViewControl.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 09/08/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

@IBDesignable class AvatarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 34.0
    private var fillColor: UIColor = .blue // для слоя тени бекграунд вспомогательный
    private var background: UIColor = .clear
    
    @IBInspectable var imageShadowColor: UIColor = .black { didSet { layoutSubviews() } }
    @IBInspectable var imageShadowOpacity: Float = 0.3 { didSet { layoutSubviews() } }
    @IBInspectable var imageShadowRadius: CGFloat = 3.0 { didSet { layoutSubviews() } }
    @IBInspectable var imageShadowOffset: CGSize = .zero { didSet { layoutSubviews() } }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowColor = imageShadowColor.cgColor
            shadowLayer.shadowOffset = imageShadowOffset
            shadowLayer.shadowOpacity = imageShadowOpacity
            shadowLayer.shadowRadius = imageShadowRadius
            shadowLayer.backgroundColor = background.cgColor
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

