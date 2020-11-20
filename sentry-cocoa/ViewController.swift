//
//  ViewController.swift
//  sentry-cocoa
//
//  Created by Ido  Shemesh on 3/25/20.
//  Copyright © 2020 Sentry. All rights reserved.
//

import UIKit
import Sentry

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SentrySDK.configureScope { (scope) in
            scope.setTag(value: "swift", key: "language")
            scope.setTag(value: "enterprise", key: "customer-type")
            scope.setExtra(value: String(describing: self), key: "currentViewController")
            
            scope.setContext(value: ["key1" : "value1",
                                     "key2" : "value2",
                                     "key3" : "value3"], key: "My Context")
        }
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sentry-pattern.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

    }
    
    @IBAction func sendMessage(_ sender: Any) {
    
        let crumb = Breadcrumb()
        crumb.message = "User clicked the button - Capture Message"
        crumb.level = SentryLevel.info
        SentrySDK.addBreadcrumb(crumb: crumb)
        
        SentrySDK.capture(message: "Capture this message")
    }
    
    @IBAction func causeCrash(_ sender: Any) {
        let crumb = Breadcrumb()
        crumb.message = "User clicked the button - Crash Application"
        crumb.level = SentryLevel.info
        SentrySDK.addBreadcrumb(crumb: crumb)
        
        SentrySDK.crash()
    }
    
    
    @IBAction func causeHandledException(_ sender: Any){
        let crumb = Breadcrumb()
        crumb.message = "User clicked the button - Handled Exception"
        crumb.level = SentryLevel.info
        SentrySDK.addBreadcrumb(crumb: crumb)
        
        do {
            try callMehtodThatThrowsError()
        } catch let error as NSError {
            SentrySDK.capture(error: error) { (scope) in
                scope.setLevel(.fatal)
            }
        }
    }
       
       
   @IBAction func causeRuntimeException(_ sender: Any) {
        let crumb = Breadcrumb()
        crumb.message = "User clicked the button - UnHandled Exception"
        crumb.level = SentryLevel.info
        SentrySDK.addBreadcrumb(crumb: crumb)
    
       //Index out of rang exception
       let listOfNumbers = [1, 2, 3]
       print(listOfNumbers[4])
   }
    
    func callMehtodThatThrowsError() throws{
        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Handled Exception"])
    }


}

