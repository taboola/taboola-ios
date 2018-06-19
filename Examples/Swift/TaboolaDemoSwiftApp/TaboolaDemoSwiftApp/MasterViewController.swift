//
//  MasterViewController.swift
//  TaboolaDemoSwiftApp
//

import Foundation
import UIKit

protocol ActionAssistantProtocol {
    func refreshChild()
    func editChild(dict: [String: String])
}

extension ActionAssistantProtocol {
    func editChild(dict: [String: String]) {
    }
}

struct ConstantsProperties {
    static let mode         = "mode"
    static let publisher    = "publisher"
    static let pageType     = "pageType"
    static let pageUrl      = "pageURL"
    static let placement    = "placement"
}

final class MasterViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    //MARK: Properties
    fileprivate let controllersClasses: [UIViewController.Type] = [TBWidgetViewController.self, TBFeedViewController.self,TBFeedCollectionView.self]
    fileprivate weak var currentChild: UIViewController?
    
    //MARK: Life cycle
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(asChildViewController: controllersClasses.first!.instantiate())
        setButtonState(button: firstButton, isSelected: true)
    }
    
    //MARK: Fileprivate functions
    fileprivate func add(asChildViewController viewController: UIViewController) {
        if let currentChild = currentChild {
            remove(asChildViewController: currentChild)
        }
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        containerView.fillWithView(viewController.view)
        viewController.didMove(toParentViewController: self)
        currentChild = viewController
    }
    
    fileprivate func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    fileprivate func notifyChild(_  action: @escaping (ActionAssistantProtocol) -> ()) {
        if let child = currentChild as? ActionAssistantProtocol {
            action(child)
        }
    }
    
    fileprivate func setButtonState(button:UIButton, isSelected:Bool) {
        if isSelected {
            selectedStateButton(button: button)
        } else {
            noSelectedStateButton(button: button)
        }
    }
    
    fileprivate func selectedStateButton(button: UIButton) {
        button.setTitleColor(.black, for: .normal)
    }
    
    fileprivate func noSelectedStateButton(button: UIButton) {
        button.setTitleColor(.lightGray, for: .normal)
    }
}

//MARK: Extensions

private extension MasterViewController {
    
    @IBAction func actionSelectTab(_ sender: UIButton) {
        add(asChildViewController: controllersClasses[sender.tag].instantiate())
        setButtonState(button: firstButton, isSelected:sender === firstButton)
        setButtonState(button: secondButton, isSelected:sender === secondButton)
    }
    
    @IBAction func refreshPressed(sender: UIButton) {
        notifyChild { $0.refreshChild() }
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        let editController: EditViewController = EditViewController.instantiate()
        editController.handler = { [weak self] dictionary in
            self?.notifyChild { $0.editChild(dict: dictionary) }
        }
        show(editController, sender: self)
    }
}
    
