//
//  TBFeedCollectionView.swift
//  TaboolaDemoSwiftApp
//
//  Created by Tzufit Lifshitz on 6/19/18.
//  Copyright © 2018 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

private let taboolaCellIdentifier = "TaboolaCell"
private let randomCellIdentifier = "randomCell"

class TaboolaCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var taboolaView: TaboolaView!
}

class TBFeedCollectionView: UICollectionViewController , TaboolaViewDelegate {
    
    var taboolaSection = 1
    var taboolaCell:TaboolaCollectionViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: taboolaCellIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == taboolaSection {
            if  taboolaCell == nil {
                taboolaCell = collectionView.dequeueReusableCell(withReuseIdentifier: taboolaCellIdentifier, for: indexPath) as? TaboolaCollectionViewCell
                taboolaCell!.taboolaView.delegate = self
                taboolaCell!.taboolaView.mode = "thumbnails-feed"
                taboolaCell!.taboolaView.publisher = "betterbytheminute-app"
                taboolaCell!.taboolaView.pageType = "article"
                taboolaCell!.taboolaView.pageUrl = "http://www.example.com"
                taboolaCell!.taboolaView.placement = "feed-sample-app"
                taboolaCell!.taboolaView.targetType = "mix"
                taboolaCell!.taboolaView.enableClickHandler = true
                taboolaCell!.taboolaView.setInterceptScroll(true)
                taboolaCell!.taboolaView.fetchContent()
            }
            return taboolaCell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: randomCellIdentifier, for: indexPath)
            return cell
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
