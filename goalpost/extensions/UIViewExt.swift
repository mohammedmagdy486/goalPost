//
//  UIViewExt.swift
//  goalpost
//
//  Created by AMN on 3/20/22.
//

import UIKit
extension UIView {
    func bindToKeyboard (){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyBoardWillChange(_ notification: NSNotification){
        let duration = notification.userInfo![UIView.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIView.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notification.userInfo![UIView.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo![UIView.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endingFrame.origin.y - startingFrame.origin.y
        let options = KeyframeAnimationOptions(rawValue: curve)
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: options, animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
}
