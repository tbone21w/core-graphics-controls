//
//  GraphView.swift
//  Flo
//
//  Created by Todd Isaacs on 8/19/15.
//  Copyright (c) 2015 Todd Isaacs. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {

   //storyboard inspectable props
   @IBInspectable var startColor: UIColor = UIColor.redColor()
   @IBInspectable var endColor: UIColor = UIColor.greenColor()
   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
      //current drawing context
      let context = UIGraphicsGetCurrentContext();
      
      let colors = [startColor.CGColor, endColor.CGColor]
      
      //color stops for color change over so at 0 we have start color and 1 we have end color
      let colorLocations:[CGFloat] = [0.0, 1.0]
      
      //get colorspace we want to use
      let colorSpace = CGColorSpaceCreateDeviceRGB()
      
      let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
      
      //draw the gradient
      var startPoint = CGPoint.zeroPoint
      var endPoint = CGPoint(x: 0, y: self.bounds.height)
      CGContextDrawLinearGradient(context,
         gradient,
         startPoint,
         endPoint,
         0)
    }


}
