//
//  ViewController.swift
//  TaboolaDemoSwiftApp
//

import UIKit
import TaboolaSDK

class FirstViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var mTaboolaView: TaboolaView!
    @IBOutlet weak var mTextLabel: UILabel!
    @IBOutlet weak var mScrollView: UIScrollView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTaboolaView.delegate = self
        mTaboolaView.ownerViewController = self
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
}
// MARK: Extensions
extension FirstViewController: TaboolaViewDelegate {
    func taboolaViewItemClickHandler(_ pURLString: String!, _ isOrganic: Bool) -> Bool {
        return true
    }
}

extension FirstViewController: ActionAssistantProtocol {
    func refreshChild() {
        mTaboolaView.refresh()
    }
    
    func editChild(dict: [String : String]) {
        mTaboolaView.mode = dict[ConstantsProperties.mode]
        mTaboolaView.publisher = dict[ConstantsProperties.publisher]
        mTaboolaView.pageType = dict[ConstantsProperties.pageType]
        mTaboolaView.pageUrl = dict[ConstantsProperties.pageUrl]
        mTaboolaView.placement = dict[ConstantsProperties.placement]
        mTaboolaView.fetchContent()
    }
}

