//
//  UIViewControllerExtension.swift
//  TaboolaDemoSwiftApp
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiate<T: UIViewController>() -> T {
        let storyboardIdentifier = "\(self)"
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
}
