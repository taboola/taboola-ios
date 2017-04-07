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
        
        taboolaView.mode = "thumbnails-h"
        taboolaView.publisher = "lexpress-network"
        taboolaView.pageType = "article"
        taboolaView.pageUrl = "www.lexpress.fr"
        taboolaView.placement = "iOS Below Article Thumbnails"
        
        // Optional - add extra styling rules to the widget, CSS format.
        taboolaView.optionalWidgetStyle = "background:linear-gradient(135deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(225deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(315deg, #ECEDDC 25%, transparent 25%),linear-gradient(45deg, #ECEDDC 25%, transparent 25%)background-size: 100px 100pxbackground-color: #EC173A"
        
        // Optional - control the color of the browser title text
        taboolaView.browserTitleTextColor = UIColor.yellow
        
        let pageDict = ["referrer": "http://www.example.com/ref"]
        taboolaView.setOptionalPageCommands(pageDict)
        
        let lModeDictionary = ["mix":"target_type"]
        taboolaView.setOptionalModeCommands(lModeDictionary)
        taboolaView.fetchContent()
    }
}

// MARK: Extensions
extension SecondViewController: TaboolaViewDelegate {
    func taboolaViewItemClickHandler(_ pURLString: String!, _ isOrganic: Bool) -> Bool {
        return true
    }
}
