//
//  SecondViewController.swift
//  TaboolaDemoSwiftApp
//

import UIKit
import TaboolaSDK

class SecondViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var taboolaView: TaboolaView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taboolaView.delegate = self
        taboolaView.ownerViewController = self
        taboolaView.autoResizeHeight = true
        taboolaView.scrollEnable = false
        taboolaView.enableClickHandler = true
        
        taboolaView.mode = "thumbnails-sdk1"
        taboolaView.publisher = "betterbytheminute-app"
        taboolaView.pageType = "article"
        taboolaView.pageUrl = "http://www.example.com"
        taboolaView.placement = "Mobile"
        taboolaView.targetType = "mix"
        
        // Optional - add extra styling rules to the widget, CSS format.
        taboolaView.optionalWidgetStyle = "background:linear-gradient(135deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(225deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(315deg, #ECEDDC 25%, transparent 25%),linear-gradient(45deg, #ECEDDC 25%, transparent 25%)background-size: 100px 100pxbackground-color: #EC173A"
        
        // Optional - control the color of the browser title text
        taboolaView.browserTitleTextColor = UIColor.yellow
        
        let pageDict = ["referrer": "http://www.example.com/ref"]
        taboolaView.setOptionalPageCommands(pageDict)
        
        taboolaView.fetchContent()
    }
}

// MARK: Extensions
extension SecondViewController: TaboolaViewDelegate {
    func taboolaViewItemClickHandler(_ pURLString: String!, _ isOrganic: Bool) -> Bool {
        return true
    }
}
