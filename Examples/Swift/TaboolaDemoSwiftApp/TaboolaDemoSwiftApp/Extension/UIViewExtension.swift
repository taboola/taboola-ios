//
//  UIViewExtension.swift
//  TaboolaDemoSwiftApp
//

import Foundation
import UIKit

extension UIView {
    func fillWithView(_ otherView: UIView) {
        otherView.translatesAutoresizingMaskIntoConstraints = false
        otherView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        otherView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        otherView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        otherView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
