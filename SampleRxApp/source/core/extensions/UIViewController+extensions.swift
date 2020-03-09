//
//  UIViewController+extensions.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit

public extension UIViewController {

    class func loadFromStoryboard(name: String? = nil, identifier: String? = nil, bundle: Bundle? = nil) -> Self {
        let defaultIdentifier = String(describing: self)
        let bundle = bundle ?? Bundle(for: self)
        let storyboardName = name ?? defaultIdentifier
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        if let identifier = identifier {
            return storyboard.instantiateViewController(identifier: identifier) as! Self
        } else {
            return storyboard.instantiateViewController(identifier: defaultIdentifier) as! Self
        }
    }

}
