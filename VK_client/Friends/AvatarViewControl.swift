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
        clipsToBounds = true
//        layer.masksToBounds = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }



    @IBInspectable var shadowColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }




}
