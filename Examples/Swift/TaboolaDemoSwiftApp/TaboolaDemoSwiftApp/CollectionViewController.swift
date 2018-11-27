//
//  CollectionViewController.swift
//  BildExample
//
//  Created by Tzufit Lifshitz on 11/26/18.
//  Copyright © 2018 Taboola. All rights reserved.
//

import UIKit
import TaboolaSDK

class TaboolaCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var taboolaView: TaboolaView!
}

class CollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var taboolaSection = 1
    var taboolaCell:TaboolaCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == taboolaSection {
            if  taboolaCell == nil {
                taboolaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaboolaCell", for: indexPath) as? TaboolaCollectionViewCell
                taboolaCell!.taboolaView.delegate = self
                taboolaCell!.taboolaView.mode = "thumbnails-b";
                taboolaCell!.taboolaView.publisher = "bildappios";
                taboolaCell!.taboolaView.pageType = "article";
                taboolaCell!.taboolaView.pageUrl = "http://www.example.com";
                taboolaCell!.taboolaView.placement = "Sportbild iOS Below Article compliant";
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
        if indexPath.section == taboolaSection {
            if let taboolaView = self.taboolaCell?.taboolaView {
                let size = CGSize(width: self.view.frame.size.width, height: taboolaView.frame.size.height > 0 ? taboolaView.frame.size.height : 200)
                return size
            }
        }
        return CGSize(width:self.view.frame.width,height: 200)
    }
    
}

extension CollectionViewController: TaboolaViewDelegate {
    
    func taboolaView(_ taboolaView: UIView!, placementNamed placementName: String!, resizedToHeight height: CGFloat) {
        self.collectionView?.reloadItems(at:[IndexPath(item: 0, section: taboolaSection)])
    }
}
