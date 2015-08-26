//
//  ViewController.swift
//  AutoScrollView
//
//  Created by Zhou Hao on 26/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func keyboardWasShown(notification : NSNotification) {
    
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            let buttonOrigin = self.signInButton.frame.origin
            let buttonHeight = self.signInButton.frame.size.height
            
            var visibleRect = self.view.frame
            
            visibleRect.size.height -= keyboardSize.height
            
            if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
                
                let scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight)
                
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    
    }
    
    func keyboardWillBeHidden(notification : NSNotification) {
    
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    
    }
}

