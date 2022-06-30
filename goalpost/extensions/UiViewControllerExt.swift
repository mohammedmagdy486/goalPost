//
//  UiViewControllerExt.swift
//  goalpost
//
//  Created by AMN on 3/21/22.
//

import UIKit
extension UIViewController{
    func presentDetail (_ ViewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        ViewControllerToPresent.modalPresentationStyle = .fullScreen
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(ViewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentSecondaryDetail(_ ViewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        ViewControllerToPresent.modalPresentationStyle = .fullScreen
        guard let presentedVC = presentedViewController else { return}
        presentedVC.dismiss(animated: false) {
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(ViewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail () {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: true, completion: nil)
    }
    
}
