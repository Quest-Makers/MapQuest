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
    let fetchQuestByMenuItem: [MenuItem: (@escaping ([Quest]) -> Void) -> Void] = [.ALL_QUESTS: Quest.fetchAllQuests,
                                                                                   .MY_QUESTS: Quest.fetchMyQuests,
                                                                                   .IN_PROGRESS: Quest.fetchInProgressQuests,
                                                                                   .COMPLETED: Quest.fetchCompletedQuests]
    
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
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestDetailsViewController {
            if let cell = sender as? QuestTableViewCell {
                destination.quest = cell.quest
            }
        }
    }

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
