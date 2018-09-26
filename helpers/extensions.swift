//
//  extensions.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 27/08/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import UIKit

extension UIView{
    
    func extensionSetConstraintsWithFormat(horizontalFormat: String?,verticalFormat: String? , views: [UIView]){
        var numberAndViews: [String:UIView] = [:]
        
        for (index,item) in views.enumerated(){
            let viewIdentifier = "v\(index)"
            numberAndViews.updateValue(item, forKey: viewIdentifier)
        }
        if let horizontal = horizontalFormat {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:\(horizontal)", options: NSLayoutFormatOptions(), metrics: nil, views: numberAndViews))
        }
        if let vertical = verticalFormat {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:\(vertical)", options: NSLayoutFormatOptions(), metrics: nil, views: numberAndViews))
        }
    }
    
    func extensionSetShadowEasy(color: CGColor, offSet: CGSize){
        layer.shadowOpacity = 1
        layer.shadowColor = color
        layer.shadowOffset = offSet
    }
    
    func extensionAddSubViewAtOnce(UIViews: UIView...){
        for view in UIViews {
            self.addSubview(view)
        }
    }

    
}

extension CALayer {
    
    func createImageFromLayer(_ targetRect: CGRect?) -> UIImage?{
        if let rect = targetRect {
            frame = rect
        } else {
            frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        }
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        render(in: context)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        output?.resizableImage(withCapInsets: .zero, resizingMode: UIImageResizingMode.stretch)
        return output
    }
    
  
}


extension UITextField{
    
    func extensionAddPadding(left: CGFloat,right: CGFloat){
        let paddingViewLeft = UIView()
        paddingViewLeft.backgroundColor = UIColor.clear
        paddingViewLeft.frame = CGRect(x: 0, y: 0, width: left, height: self.frame.height)
        
        
        let paddingViewRight = UIView()
        paddingViewRight.backgroundColor = UIColor.clear
        paddingViewRight.frame = CGRect(x: self.frame.width - right, y: 0, width: right, height: self.frame.height)

        
        self.leftView = paddingViewLeft
        self.rightView = paddingViewRight
        self.leftViewMode = .always
        self.rightViewMode = .always

    }
    
    
    
    
}

extension UINavigationController{
    
    func extensionSetNavigationControllerBar(color: CGColor){
        
        let gradient: CAGradientLayer = {
            let grad = CAGradientLayer()
            grad.colors = [color,UIColor.clear.cgColor]
            grad.locations = [0,1]
            grad.startPoint = CGPoint(x: 0.5, y: 0)
            grad.endPoint = CGPoint(x: 0.5, y: 1)
            return grad
        }()
        
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        let barImg = gradient.createImageFromLayer(nil)?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        navigationBar.setBackgroundImage(barImg, for: UIBarMetrics.default)
    }
}


extension UITabBarController{
    
    func extensionSetTabBarBackgroundImage(color: CGColor){
        let grad: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.colors = [color, UIColor.clear.cgColor]
            gradient.locations = [1,0]
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
            return gradient
        }()
        
        let tabImage = grad.createImageFromLayer(self.tabBar.bounds)?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundImage = tabImage
        self.tabBar.shadowImage = UIImage()
        
    }
}

extension CGFloat {
    func toRadians() -> CGFloat{
       return self * CGFloat.pi/180
    }
}

extension Int {
    func toRadians() -> CGFloat{
        return CGFloat(self) * CGFloat.pi/180
    }
}

extension Double {
    func toRadians() -> CGFloat{
        return CGFloat(self) * CGFloat.pi/180
    }
}

