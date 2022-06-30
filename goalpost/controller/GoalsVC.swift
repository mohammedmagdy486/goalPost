//
//  GoalsVC.swift
//  goalpost
//
//  Created by AMN on 2/17/22.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {
    @IBOutlet weak var editGoal: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var goals : [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCoreDataObjects()
        tableView.reloadData()
    }
    func fetchCoreDataObjects(){
        self.fetch { complete in
            if complete {
                if goals.count >= 1{
                    tableView.isHidden = false
                }
                else{
                    tableView.isHidden = true
                }
            }
        }
    }
  private func setUp(){
      self.navigationController?.navigationBar.isHidden = true
        editGoal.addTarget(self, action: #selector(editGoalTappedFunc), for: .touchUpInside)
    }
    @objc func editGoalTappedFunc(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddGoalVC") as! AddGoalVC 
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GoalsVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configurationCell(goal: goal)
            return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { rowAction, indexPath in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { rowAction, indexPath in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return [deleteAction,addAction]
    }
    
    
    
}

extension GoalsVC{
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[indexPath.row ])
        do{
            try managedContext.save()
        }
        catch{
            debugPrint("couldn't remove\(error)")
            print("successfully removed")
        }
    }
    func fetch(completion:(_ complete:Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do{
            goals = try managedContext.fetch(fetchRequest)
            print("successfully fetched data")
            completion(true)
        }
        catch {
            debugPrint("couldn't fetch\(error.localizedDescription)")
            completion(false)
        }
    }
    func setProgress(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        }
        else {
            return
        }
        do {
            try managedContext.save()
            print("successfully save progress")
        }
        catch{
            debugPrint("couldn't Save Progress\(error.localizedDescription)")
        }
    }
}
