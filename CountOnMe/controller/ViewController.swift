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
        print("A que coucou")
    }
    
    @IBAction func tappedArgButton(_ sender: UIButton) {
        switch sender.tag {
        case 0...9: // value 0-9
            print("value", sender.tag)
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
            print("Add")
        case 101: //Substraction
            print("Sub")
        case 102: // Multiplication
            print("Mul")
        case 103: // Division
            print("Div")
        default:
            print("Nothing")
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if sender.tag == 1000 { // Equal
            print("EQUAL")
        }
    }

}

