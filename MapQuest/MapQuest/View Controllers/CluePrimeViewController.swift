//
//  CluePrimeViewController.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/25/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

extension UITableView {
    func mapQuestRegisterNib(cellClass: AnyClass) {
        let className = String(describing: cellClass)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func mapQuestDequeueReusableCellClass(cellClass: AnyClass) -> UITableViewCell {
        let className = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: className)!
    }
}


class CluePrimeViewController: UIViewController {
    
    var delegate: NewClueViewControllerDelegate? = nil

    @IBOutlet weak var tableView: UITableView!
    
    var hints: [Hint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)

        let footerView = Bundle.main.loadNibNamed("ClueFooterView", owner: self, options: nil)?.first as! ClueFooterView
        footerView.delegate = self
        tableView.tableFooterView = footerView
        
        tableView.mapQuestRegisterNib(cellClass: TextClueCell.self)
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CluePrimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hint = hints[indexPath.row]
        
        let cell = tableView.mapQuestDequeueReusableCellClass(cellClass: TextClueCell.self) as! TextClueCell
        cell.hint = hint
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hints.count
    }
}

extension CluePrimeViewController: ClueFooterViewDelegate {
    func addHint(hintType: HintType) {
        hints.append(Hint(hintType: HintType.TEXT))
        self.tableView.reloadData()
    }
    
    func addClue() {
        print(hints)
        // pass the hints back to the delegate (NewClueViewControllerDelegate)
    }
}
