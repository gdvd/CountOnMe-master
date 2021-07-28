//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var expression = Expression()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
    }
    
    @IBAction func tappedArgButton(_ sender: UIButton) {
        switch sender.tag {
        case 0...9: // value 0-9
            print("value", sender.tag)
            textView.text = expression.addArg(String(sender.tag))
        case 10: // Point
            print("Point")
        case 11: // Cancel
            print("Cancel")
        default:
            print("Nothing")
        }
    }

    @IBAction func tappedOperationButton(_ sender: UIButton) {
        switch sender.tag {
        case 100: // Addition
            if let result = expression.enterOperation("+") {
                textView.text = result
            } else {
                showAlertOnlyOneOperator()
            }
        case 101: //Substraction
            if let result = expression.enterOperation("-") {
                textView.text = result
            } else {
                showAlertOnlyOneOperator()
            }
        case 102: // Multiplication
            if let result = expression.enterOperation("*") {
                textView.text = result
            } else {
                showAlertOnlyOneOperator()
            }
        case 103: // Division
            if let result = expression.enterOperation("/") {
                textView.text = result
            } else {
                showAlertOnlyOneOperator()
            }
        default:
            print("Nothing")
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if sender.tag == 1000 { // Equal
            if let result = expression.enterOperation("=") {
                textView.text = result
            } else {
                operationFailed()
            }
        }
    }
    
    func showAlertOnlyOneOperator(){
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func operationFailed(){
        let alertVC = UIAlertController(title: "Impossible!", message: "Expression incorrecte !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

