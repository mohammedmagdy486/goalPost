//
//  AddGoalVC.swift
//  goalpost
//
//  Created by AMN on 3/20/22.
//

import UIKit

class AddGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var editGoalTxtView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longtermBtn: UIButton!
    
    var goalTyoe: GoalType = .shortTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        editGoalTxtView.delegate = self
        nextBtn.bindToKeyboard()
        shortTermBtn.setDeSelectedColor()
        longtermBtn.setSelectedColor()
        
    }
    private func setUp(){
        backButton.addTarget(self, action: #selector(backButtonTappedFunc), for: .touchUpInside)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        editGoalTxtView.text = ""
        editGoalTxtView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    @objc func backButtonTappedFunc(){
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func longTermBtnTapped(_ sender: Any) {
        goalTyoe = .longTrem
        longtermBtn.setSelectedColor()
        shortTermBtn.setDeSelectedColor()
    }
    
    @IBAction func shortTermBtnTapped(_ sender: Any) {
        goalTyoe = .shortTerm
        longtermBtn.setDeSelectedColor()
        shortTermBtn.setSelectedColor()
        
    }
    
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if editGoalTxtView.text != "" && editGoalTxtView.text != "what is your goal"{
            guard let finshGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinshGoalVC") as? FinshGoalVC else{return}
            finshGoalVC.initData(description: editGoalTxtView.text!, type: goalTyoe)
            navigationController?.pushViewController(finshGoalVC, animated: true)
        }
    }
    
}
