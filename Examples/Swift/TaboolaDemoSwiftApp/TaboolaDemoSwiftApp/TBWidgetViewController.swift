//
//  ViewController.swift
//  TaboolaDemoSwiftApp
//

import UIKit
import TaboolaSDK

class TBWidgetViewController: UIViewController {
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
        
        mTaboolaView.mode = "thumbnails-sdk3"
        mTaboolaView.publisher = "betterbytheminute-app"
        mTaboolaView.pageType = "article"
        mTaboolaView.pageUrl = "http://www.example.com"
        mTaboolaView.placement = "Mobile"

        // Optional - add extra styling rules to the widget, CSS format.
        mTaboolaView.optionalWidgetStyle = "background:linear-gradient(135deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(225deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(315deg, #ECEDDC 25%, transparent 25%),linear-gradient(45deg, #ECEDDC 25%, transparent 25%)background-size: 100px 100pxbackground-color: #EC173A"
 
        
        let pageDict = ["referrer": "http://www.example.com/ref"]
        mTaboolaView.setOptionalPageCommands(pageDict)
        
        let lModeDictionary = ["mix":"target_type"]
        mTaboolaView.setOptionalModeCommands(lModeDictionary)
        mTaboolaView.fetchContent()

    }
}
// MARK: Extensions
extension TBWidgetViewController: TaboolaViewDelegate {
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        if organic {
            print("itemId: \(itemId)")
        } else {
            print("clickUrl: \(clickUrl)")
        }
        return true
    }
    
    func taboolaView(_ taboolaView: UIView!, didLoadPlacementNamed placementName: String!, withHeight height: CGFloat) {
        print("Placement \(placementName) loaded successfully. height \(height)");
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print("Placement \(placementName) failed to load because: %@ \(error)");
    }
}

extension TBWidgetViewController: ActionAssistantProtocol {
    func refreshChild() {
//        mTaboolaView.refresh()
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




