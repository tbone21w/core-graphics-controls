//
//  PushButtonView.swift
//  Flo
//
//  Created by Todd Isaacs on 8/17/15.
//  Copyright (c) 2015 Todd Isaacs. All rights reserved.
//

import UIKit

@IBDesignable //allows live rendering in storyboard

class PushButtonView: UIButton {

   //add some xcode annotations for attribute inspection
   @IBInspectable var fillColor: UIColor = UIColor.greenColor()
   @IBInspectable var isAddButton: Bool = true
   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   override func drawRect(rect: CGRect) {
      
      //Draw round circle
      var path = UIBezierPath(ovalInRect: rect)
      fillColor.setFill()  //set the contect fill color
      path.fill()
      
      //draw plus signs
      //set the width and height of the plus stroke
      let plusHeight: CGFloat = 3.0
      let plusWidth: CGFloat = min(bounds.width, bounds.height ) * 0.6
      
      var plusPath = UIBezierPath()
      plusPath.lineWidth = plusHeight
      
      //Horizontal
      //move the start point of the path
      plusPath.moveToPoint(CGPoint(
         x:bounds.width/2 - plusWidth/2 + 0.5,
         y:bounds.height/2 + 0.5))
      
      //add a point to the path at the end of the stroke
      plusPath.addLineToPoint(CGPoint(
         x:bounds.width/2 + plusWidth/2 + 0.5,
         y:bounds.height/2 + 0.5))
      
      //Veritical
      if isAddButton {
         //move the start point of the path
         plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 - plusWidth/2 + 0.5))
      
         //add a point to the path at the end of the stroke
         plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 + plusWidth/2 + 0.5))
      }
      
      //set the stroke color in the context
      UIColor.whiteColor().setStroke()
      
      plusPath.stroke()
    }


}
