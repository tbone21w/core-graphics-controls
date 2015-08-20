//
//  ViewController.swift
//  Flo
//
//  Created by Todd Isaacs on 8/17/15.
//  Copyright (c) 2015 Todd Isaacs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBOutlet weak var counterView:CounterView!
   @IBOutlet weak var counterLabel:UILabel!
   @IBOutlet weak var containerView:UIView!
   @IBOutlet weak var graphView:GraphView!
   
   var isGraphViewShowing = false
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      counterLabel.text = String(counterView.counter)
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   @IBAction func btnPushButton(button: PushButtonView) {
      if button.isAddButton {
         if counterView.counter < 8 {
            counterView.counter++
         }
      } else {
         if counterView.counter > 0 {
            counterView.counter--
         }
      }
      
      counterLabel.text = String(counterView.counter)
      
      //go back to counter
      if isGraphViewShowing {
         counterViewTap(nil)
      }
   }

   @IBAction func counterViewTap(gesture:UITapGestureRecognizer?) {
      if isGraphViewShowing {
         //hide Graph
         UIView.transitionFromView(graphView,
            toView: counterView,
            duration: 1.0,
            options: UIViewAnimationOptions.TransitionFlipFromLeft
               | UIViewAnimationOptions.ShowHideTransitionViews,
            completion: nil)
      } else {
         //show Graph
         UIView.transitionFromView(counterView,
            toView: graphView,
            duration: 1.0,
            options: UIViewAnimationOptions.TransitionFlipFromRight
               | UIViewAnimationOptions.ShowHideTransitionViews,
            completion: nil)
      }
   }

}

