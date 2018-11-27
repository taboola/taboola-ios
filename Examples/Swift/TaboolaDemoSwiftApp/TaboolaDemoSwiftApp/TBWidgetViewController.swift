//
//  ViewController.swift
//  TaboolaDemoSwiftApp
//

import UIKit
import TaboolaSDK

class TBWidgetViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var topTaboolaView: TaboolaView!
    @IBOutlet weak var bottomTaboolaView: TaboolaView!
    @IBOutlet weak var mTextLabel: UILabel!
    @IBOutlet weak var mScrollView: UIScrollView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTaboolaView.delegate = self
        topTaboolaView.ownerViewController = self
        topTaboolaView.mode = "thumbnails-sdk3"
        topTaboolaView.publisher = "betterbytheminute-app"
        topTaboolaView.pageType = "article"
        topTaboolaView.pageUrl = "http://www.example.com"
        topTaboolaView.placement = "Mobile top"
        topTaboolaView.fetchContent()
        
        bottomTaboolaView.delegate = self
        bottomTaboolaView.ownerViewController = self
        bottomTaboolaView.mode = "thumbnails-sdk1"
        bottomTaboolaView.publisher = "betterbytheminute-app"
        bottomTaboolaView.pageType = "article"
        bottomTaboolaView.pageUrl = "http://www.example.com"
        bottomTaboolaView.placement = "Mobile"
        bottomTaboolaView.fetchContent()

    }
}
// MARK: Extensions
extension TBWidgetViewController: TaboolaViewDelegate {
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        if organic {
            print("itemId: \(String(describing: itemId))")
        } else {
            print("clickUrl: \(String(describing: clickUrl))")
        }
        return true
    }
    
    func taboolaView(_ taboolaView: UIView!, didLoadPlacementNamed placementName: String!, withHeight height: CGFloat) {
        print("Placement \(String(describing: placementName)) loaded successfully. height \(height)");
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print("Placement \(String(describing: placementName)) failed to load because: %@ \(String(describing: error))");
    }
}




