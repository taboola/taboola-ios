//
//  CollectionViewController.swift
//  BildExample
//
//  Created by Tzufit Lifshitz on 11/26/18.
//  Copyright © 2018 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class TBWidgetCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var taboolaView: TaboolaView!
}

class TBWidgetCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var taboolaCellIndex = 1
    var taboolaCell:TBWidgetCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == taboolaCellIndex {
            if  taboolaCell == nil {
                taboolaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaboolaCell", for: indexPath) as? TBWidgetCollectionViewCell
                taboolaCell!.taboolaView.delegate = self
                taboolaCell!.taboolaView.ownerViewController = self
                taboolaCell!.taboolaView.mode = "thumbnails-sdk1";
                taboolaCell!.taboolaView.publisher = "betterbytheminute-app";
                taboolaCell!.taboolaView.pageType = "article";
                taboolaCell!.taboolaView.pageUrl = "http://www.example.com";
                taboolaCell!.taboolaView.placement = "iOS Below Article Thumbnails";
                taboolaCell!.taboolaView.targetType = "mix";
                taboolaCell!.taboolaView.fetchContent()
            }
            return taboolaCell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == taboolaCellIndex {
            if let taboolaView = self.taboolaCell?.taboolaView {
                let size = CGSize(width: self.view.frame.size.width, height: taboolaView.frame.size.height > 0 ? taboolaView.frame.size.height : 200)
                return size
            }
        }
        return CGSize(width:self.view.frame.width,height: 200)
    }
    
}

extension TBWidgetCollectionViewController: TaboolaViewDelegate {
    
    func taboolaView(_ taboolaView: UIView!, placementNamed placementName: String!, resizedToHeight height: CGFloat) {
        self.collectionView?.reloadItems(at:[IndexPath(item: taboolaCellIndex, section: 0)])
    }
    
    func taboolaView(_ taboolaView: UIView!, didLoadPlacementNamed placementName: String!, withHeight height: CGFloat) {
        //
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        //
    }
    
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        return true
    }
}
