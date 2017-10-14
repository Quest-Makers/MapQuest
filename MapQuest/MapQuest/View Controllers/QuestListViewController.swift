//
//  QuestListViewController.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit



class QuestListViewController: UIViewController {

    @IBOutlet weak var questListTableView: UITableView!
    
    var quests: [Quest] = []
    let fetchQuestByMenuItem: [MenuItem: (([Quest]) -> Void) -> Void] = [.ALL_QUESTS: MapQuestClient.getInstance().fetchAllQuests,
                                                                         .MY_QUESTS: MapQuestClient.getInstance().fetchMyQuests,
                                                                         .IN_PROGRESS: MapQuestClient.getInstance().fetchInProgressQuests,
                                                                         .COMPLETED: MapQuestClient.getInstance().fetchCompletedQuests]
    
    var questList: MenuItem! {
        didSet {
            view.layoutIfNeeded()
            fetchQuestByMenuItem[questList]!(
                { (quests: [Quest]) -> Void in
                    self.quests = quests
                    self.questListTableView.reloadData()
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        questListTableView.delegate = self
        questListTableView.dataSource = self
        
        questListTableView.estimatedRowHeight = 250
        questListTableView.rowHeight = UITableViewAutomaticDimension

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

extension QuestListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestListCell") as! QuestTableViewCell
        cell.quest = quests[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count
    }
    
}
