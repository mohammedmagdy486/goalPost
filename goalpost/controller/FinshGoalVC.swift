//
//  FinshGoalVC.swift
//  goalpost
//
//  Created by AMN on 6/21/22.
//

import UIKit
import CoreData

class FinshGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTF: UITextField!
   
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var goalDescription: String?
    var goaltype: GoalType?
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goaltype = type
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTF.delegate = self
        
    }
    
    func save(completion:(_ finished: Bool ) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return} // get the managed context
        let goal = Goal(context: managedContext) // instance of goal Entity and Pass the context to know where to save the data
        goal.goalDescription = goalDescription
        goal.goalType = goaltype?.rawValue
        goal.goalCompletionValue = Int32(pointsTF.text!)!
        goal.goalProgress = Int32(0)
        // the last few lines were for making the model
        // to pass this model to persistent store
        do {
            try managedContext.save() // because this is a throw it has to be done in do catch
            print("success")
            completion(true) // this means the save has been done correctly
        }
        catch{
            debugPrint("could not save\(error.localizedDescription)")
            completion(false) // this means the save hasn't been done correctly
        }
    }
    
    @IBAction func createGoalBtnTapped(_ sender: Any) {
        // pass data into CoreData Goal Model
        if pointsTF.text != "" { // check the pointsTF to have value
        self.save{(complete) in
            if complete {
                navigationController?.popToRootViewController(animated: true)
            }
        }
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismissDetail()
    }
    
}
