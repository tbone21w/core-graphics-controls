//
//  CounterView.swift
//  Flo
//
//  Created by Todd Isaacs on 8/18/15.
//  Copyright (c) 2015 Todd Isaacs. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)  //ALT-p

@IBDesignable class CounterView: UIView {
   
   @IBInspectable var counter: Int = 5 {
      didSet {
         if counter <= NoOfGlasses {
            //view needs refreshed
            setNeedsDisplay()
         }
      }
   }
   
   @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
   @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
   
   override func drawRect(rect: CGRect) {
      
      let center = CGPoint(x:bounds.width/2, y:bounds.height/2)
      
      //get the max radius based on the size of this view
      let radius: CGFloat = max(bounds.width, bounds.height)
      
      let arcWidth: CGFloat = 76
      
      let startAngle: CGFloat = 3 * π / 4    // 135 degrees
      let endAngle: CGFloat = π / 4          //  45 degrees
      
      var path = UIBezierPath(arcCenter: center,
         radius: radius/2 - arcWidth/2,
         startAngle: startAngle,
         endAngle: endAngle,
         clockwise: true)
      
      path.lineWidth = arcWidth
      
      //set the stroke color in the graphcs context and draw
      counterColor.setStroke()
      path.stroke()
      
      
      //Draw the outline
      
      //1 - first calculate the difference between the two angles
      //ensuring it is positive
      let angleDifference: CGFloat = 2 * π - startAngle + endAngle
      
      //then calculate the arc for each single glass
      let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
      
      //then multiply out by the actual glasses drunk
      let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
      
      //2 - draw the outer arc
      var outlinePath = UIBezierPath(arcCenter: center,
         radius: bounds.width/2 - 2.5,
         startAngle: startAngle,
         endAngle: outlineEndAngle,
         clockwise: true)
      
      //3 - draw the inner arc
      outlinePath.addArcWithCenter(center,
         radius: bounds.width/2 - arcWidth + 2.5,
         startAngle: outlineEndAngle,
         endAngle: startAngle,
         clockwise: false)
      
      //4 - close the path
      outlinePath.closePath()
      
      outlineColor.setStroke()
      outlinePath.lineWidth = 5.0
      outlinePath.stroke()
   }
}
