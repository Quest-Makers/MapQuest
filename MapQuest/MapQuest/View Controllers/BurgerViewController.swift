//
//  BurgerViewController.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/13/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class BurgerViewController: UIViewController {
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet (oldMenuViewController) {
            
            view.layoutIfNeeded()

            if oldMenuViewController != nil {
                oldMenuViewController.willMove(toParentViewController: nil)
                oldMenuViewController.view.removeFromSuperview()
                oldMenuViewController.didMove(toParentViewController: nil)
            }
            
            menuViewController.willMove(toParentViewController: self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMove(toParentViewController: self)
        }
    }
    
    var contentNavigationController: UINavigationController! {
        didSet (oldContentNavigationController){
            view.layoutIfNeeded()
            
            if oldContentNavigationController != nil {
                oldContentNavigationController.willMove(toParentViewController: nil)
                oldContentNavigationController.view.removeFromSuperview()
                oldContentNavigationController.didMove(toParentViewController: nil)
            }
            
            contentNavigationController.willMove(toParentViewController: self)
            contentView.addSubview(contentNavigationController.view)
            contentNavigationController.didMove(toParentViewController: self)
            UIView.animate(withDuration: 0.3) {
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        menuViewController = mainStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leftMarginConstraint.constant
        }
        else if sender.state == UIGestureRecognizerState.changed {
            leftMarginConstraint.constant = originalLeftMargin + translation.x
        }
        else if sender.state == UIGestureRecognizerState.ended {
            
            UIView.animate(withDuration: 0.1, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 100
                }
                else {
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
