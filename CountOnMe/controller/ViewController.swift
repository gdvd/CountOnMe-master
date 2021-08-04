//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- Init
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

//MARK:- Buttons
//MARK: Button Arguments
    @IBAction func tappedArgButton(_ sender: UIButton) {
        switch sender.tag {
        case 0...9: // value 0-9
            switch expression.addArg(String(sender.tag)){
                case .failure(let error):
                    shoWError(error)
                case .success(let  result):
                    textView.text = result
            }
        case 10: // Point
            switch expression.addPoint(){
                case .failure(let error):
                    shoWError(error)
                case .success(let  result):
                    textView.text = result
            }
        case 11: // Cancel
            switch expression.cancel() {
            case .success(let  result):
                textView.text = result
            case .failure(let  error):
                shoWError(error)
            }
        default:
            fatalError("Error : tappedArgButton")
        }
    }
    
//MARK: Button Operations
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        switch sender.tag {
        case 100: // Addition
            switch expression.enterOperation("+") {
            case .failure(let error):
                shoWError(error)
            case .success(let  result):
                textView.text = result
            }
        case 101: //Substraction
            switch expression.enterOperation("-") {
            case .failure(let error):
                shoWError(error)
            case .success(let  result):
                textView.text = result
            }
        case 102: // Multiplication
            switch expression.enterOperation("*") {
            case .failure(let error):
                shoWError(error)
            case .success(let  result):
                textView.text = result
            }
        case 103: // Division
            switch expression.enterOperation("/") {
            case .failure(let error):
                shoWError(error)
            case .success(let  result):
                textView.text = result
            }
        default:
            fatalError("Error : tappedOperationButton()")
        }
    }
    
//MARK: Button Equal
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if sender.tag == 1000 { // Equal
            switch expression.enterEqual() {
                case .failure(let error):
                    shoWError(error)
                case .success(let  result):
                    let _ = expression.reset()
                    textView.text = result
            }
        }
    }
    
    //MARK:- Alert dialogueBox
    fileprivate func shoWError(_ error: (expressionError)) {
        switch error {
        case .errorOperator:
            operationError("operateur est déja mis !")
        case .errorExpression:
            operationError("Expression incorrecte !")
        case .impossibleDivisionByZero:
            operationError("La division par zéro est impossible !")
        case .errorOnlyOnePoint:
            operationError("Un seul point par argument !")
        }
    }    
    func operationError(_ msg: String){
        let alertVC = UIAlertController(title: "Impossible!", message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

