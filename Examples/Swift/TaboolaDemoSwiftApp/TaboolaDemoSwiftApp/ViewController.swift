//
//  ViewController.swift
//  TaboolaDemoSwiftApp
//

import UIKit
import TaboolaSDK

class ViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var mTaboolaView: TaboolaView!
    @IBOutlet weak var mTextLabel: UILabel!
    @IBOutlet weak var mScrollView: UIScrollView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTaboolaView.delegate = self
        mTaboolaView.ownerViewController = self
        mTaboolaView.mode = "thumbnails-h"
        mTaboolaView.publisher = "cbsinteractive-cbssportsmobileapp"
        mTaboolaView.pageType = "article"
        mTaboolaView.pageUrl = "http://www.example.com"
        mTaboolaView.placement = "Mobile"
        mTaboolaView.autoResizeHeight = true
        mTaboolaView.scrollEnable = false
        mTaboolaView.enableClickHandler = true
        
        // Optional - add extra styling rules to the widget, CSS format.
        mTaboolaView.optionalWidgetStyle = "background:linear-gradient(135deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(225deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(315deg, #ECEDDC 25%, transparent 25%),linear-gradient(45deg, #ECEDDC 25%, transparent 25%)background-size: 100px 100pxbackground-color: #EC173A"
        
        // Optional - control the color of the browser title text
        mTaboolaView.browserTitleTextColor = UIColor.yellow
        
        let pageDict = ["referrer": "http://www.example.com/ref"]
        mTaboolaView.setOptionalPageCommands(pageDict)
        
        let lModeDictionary = ["mix":"target_type"]
        mTaboolaView.setOptionalModeCommands(lModeDictionary)
        
        mTaboolaView.fetchContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mScrollView.center = CGPoint.init(x: mScrollView.frame.size.width/2, y: mScrollView.contentSize.height - mTaboolaView.frame.size.height/2)
    }
    
    // MARK: Buttons
    @IBAction func refreshButtonPressed(_ sender: Any) {
        mTaboolaView.refresh()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        mTaboolaView.reset()
    }
    
    @IBAction func fetchButtonPressed(_ sender: Any) {
        mTaboolaView.fetchContent()
    }
    
}
// MARK: TaboolaViewDelegate extension
extension ViewController: TaboolaViewDelegate {
    func taboolaViewItemClickHandler(_ pURLString: String!, _ isOrganic: Bool) -> Bool {
        return true
    }
    
}

