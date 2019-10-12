//
//  UINavigationController+Hidden.swift
//  NavHiddenDemo
//
//  Created by Dylan Chen on 2019/10/12.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func hideNavigationBarBGView() {
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = .clear
    }
    
    func showNavigationBarBGView() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
    }
}

