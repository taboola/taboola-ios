//
//  TaboolaDemoSwiftAppTests.swift
//  TaboolaDemoSwiftAppTests
//
//  Created by Tzufit Lifshitz on 1/9/18.
//  Copyright © 2018 Taboola. All rights reserved.
//

import TaboolaSDK
import XCTest

class TaboolaDemoSwiftAppTests: XCTestCase, TaboolaViewDelegate {
    
    private var didReceiveAdExpectation: XCTestExpectation!
    private var adView: UIView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTaboolaDidReceiveAd() {
        didReceiveAdExpectation = expectation(description: "taboolaDidReceiveAd")
        
        let taboolaView = TaboolaView()
        taboolaView.delegate = self
        taboolaView.autoResizeHeight = true
        taboolaView.scrollEnable = false
        taboolaView.enableClickHandler = true
        
        taboolaView.mode = "thumbnails-sdk1"
        taboolaView.publisher = "betterbytheminute-app"
        taboolaView.pageType = "article"
        taboolaView.pageUrl = "http://www.example.com"
        taboolaView.placement = "Mobile"
        taboolaView.targetType = "mix"
        
        let pageDict = ["referrer": "http://www.example.com/ref"]
        taboolaView.setOptionalPageCommands(pageDict)
        
        taboolaView.fetchContent()
        
        // Waits 20 seconds for results.
        // Timeout is always treated as a test failure.
        waitForExpectations(timeout: 20)
        XCTAssertNotNil(self.adView)
    }
    
    func taboolaDidReceiveAd(_ view: UIView!) {
        adView = view
        didReceiveAdExpectation.fulfill()
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
