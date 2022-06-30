//
//  GoalCell.swift
//  goalpost
//
//  Created by AMN on 2/17/22.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var completionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configurationCell (goal: Goal){
        self.descriptionLabel.text = goal.goalDescription
        self.typeLabel.text = goal.goalType
        self.progressLabel.text = String(goal.goalProgress)
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        }
        else {
            self.completionView.isHidden = true
        }
    }
   

}
