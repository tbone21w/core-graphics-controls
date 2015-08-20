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
   
   //Weekly sample data
   var graphPoints:[Int] = [4, 2, 6, 4, 5, 8, 3]
   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
      
      let width = rect.width
      let height = rect.height
      
      //set up background clipping area for rounded rect
      var path = UIBezierPath(roundedRect: rect,
         byRoundingCorners: UIRectCorner.AllCorners,
         cornerRadii: CGSize(width: 8.0, height: 8.0))
      path.addClip()
      
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
      
      //calculate the x point
      let margin:CGFloat = 20.0
      var columnXPoint = { (column:Int) -> CGFloat in
         //Calculate gap between points
         let spacer = (width - margin*2 - 4) /
            CGFloat((self.graphPoints.count - 1))
         var x:CGFloat = CGFloat(column) * spacer
         x += margin + 2
         return x
      }
      
      // calculate the y point
      let topBorder:CGFloat = 60
      let bottomBorder:CGFloat = 50
      let graphHeight = height - topBorder - bottomBorder
      let maxValue = maxElement(graphPoints)
      var columnYPoint = { (graphPoint:Int) -> CGFloat in
         var y:CGFloat = CGFloat(graphPoint) /
            CGFloat(maxValue) * graphHeight
         y = graphHeight + topBorder - y // Flip the graph
         return y
      }
      
      // draw the line graph
      UIColor.whiteColor().setFill()
      UIColor.whiteColor().setStroke()
      
      //set up the points line
      var graphPath = UIBezierPath()
      //go to start of line
      graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
         y:columnYPoint(graphPoints[0])))
      
      //add points for each item in the graphPoints array
      //at the correct (x, y) for the point
      for i in 1..<graphPoints.count {
         let nextPoint = CGPoint(x:columnXPoint(i),
            y:columnYPoint(graphPoints[i]))
         graphPath.addLineToPoint(nextPoint)
      }
      
      graphPath.stroke()
      
      //Create the clipping path for the graph gradient
      
      //1 - save the state of the context (commented out for now)
      CGContextSaveGState(context)
      
      //2 - make a copy of the path
      var clippingPath = graphPath.copy() as! UIBezierPath
      
      //3 - add lines to the copied path to complete the clip area
      clippingPath.addLineToPoint(CGPoint(
         x: columnXPoint(graphPoints.count - 1),
         y:height))
      clippingPath.addLineToPoint(CGPoint(
         x:columnXPoint(0),
         y:height))
      clippingPath.closePath()
      
      //4 - add the clipping path to the context
      clippingPath.addClip()
      
      let highestYPoint = columnYPoint(maxValue)
      startPoint = CGPoint(x:margin, y: highestYPoint)
      endPoint = CGPoint(x:margin, y:self.bounds.height)
      
      CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
      CGContextRestoreGState(context)
      
      //draw the line on top of the clipped gradient
      graphPath.lineWidth = 2.0
      graphPath.stroke()
      
      
      //Draw the circles on top of graph stroke
      for i in 0..<graphPoints.count {
         var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
         point.x -= 5.0/2
         point.y -= 5.0/2
         
         let circle = UIBezierPath(ovalInRect:
            CGRect(origin: point,
               size: CGSize(width: 5.0, height: 5.0)))
         circle.fill()
      }
      
      //Draw horizontal graph lines on the top of everything
      var linePath = UIBezierPath()
      
      //top line
      linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
      linePath.addLineToPoint(CGPoint(x: width - margin,
         y:topBorder))
      
      //center line
      linePath.moveToPoint(CGPoint(x:margin,
         y: graphHeight/2 + topBorder))
      linePath.addLineToPoint(CGPoint(x:width - margin,
         y:graphHeight/2 + topBorder))
      
      //bottom line
      linePath.moveToPoint(CGPoint(x:margin,
         y:height - bottomBorder))
      linePath.addLineToPoint(CGPoint(x:width - margin,
         y:height - bottomBorder))
      let color = UIColor(white: 1.0, alpha: 0.3)
      color.setStroke()
      
      linePath.lineWidth = 1.0
      linePath.stroke()
      
    }//END drawRect


}
