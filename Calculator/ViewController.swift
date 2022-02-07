//
//  ViewController.swift
//  Calculator
//
//  Created by Vrushank on 2022-01-30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var advanceBtn: UIButton!
    
    @IBOutlet weak var resultHistory: UITextView!
    
    
    var mycalc = Calculator();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        resultHistory.isEditable = false;
        
        //advance history textview would be hidden by default using isHidden property
        resultHistory.isHidden = true;
    }
    
    
    
    @IBAction func calcButtons(_ sender: Any) {
        if sender is UIButton{
            //Created alert action which would be performed if error would occured
            let defaultAction = UIAlertAction(title: "OK",
                                              style: .default) { [self] (action) in
                self.mycalc.nums = []
                self.resultLabel.text = self.mycalc.nums.joined(separator: " ")
                self.mycalc.operator_error = false
            }
            
            //AlertController would control the alert and it would give the alert message and would perform the alert actions defined in default action
            let alert:UIAlertController = UIAlertController(title: "Error", message: "Operator or Operand Error!", preferredStyle: UIAlertController.Style.alert)
            
            //If advance history is not enabled it would perform standard operation without displaying history in textview
            if resultHistory.isHidden == true{
                //Get the clicked button titleLabel using optional binding
                if let title = (sender as! UIButton).titleLabel?.text{
                    //Clear results
                    if title == "C"{
                        mycalc.nums = []
                        resultLabel.text = mycalc.nums.joined(separator: " ")
                    }
                    //Display result
                    else if(title == "="){
                        let result_calc = mycalc.calc()
                        resultLabel.text = mycalc.nums.joined(separator: " ") + " = " + String(result_calc)
                    }
                    //If digit is pressed append the digit to nums array
                    else{
                        mycalc.push(s:title)
                        if(mycalc.operator_error == true){
                            alert.addAction(defaultAction)
                            present(alert, animated: true, completion: nil)
                        }
                        else{
                        resultLabel.text = mycalc.nums.joined(separator: " ")
                        }
                    }
                }
            }
            else{
                //Advance history is enabled and then it would display history in textview
                if let title = (sender as! UIButton).titleLabel?.text{
                    if title == "C"{
                        mycalc.nums = []
                        resultLabel.text = mycalc.nums.joined(separator: " ")
                    }
                    else if(title == "="){
                        let result_calc = mycalc.calc()
                        resultLabel.text = mycalc.nums.joined(separator: " ") + " = " + String(result_calc)
                        
                        resultHistory.text = resultHistory.text + "\n" +  mycalc.nums.joined(separator: " ") + " = " + String(result_calc)
                    }
                    else{
                        mycalc.push(s:title)
                        if(mycalc.operator_error == true){
                            alert.addAction(defaultAction)
                            present(alert, animated: true, completion: nil)
                        }
                        else{
                        resultLabel.text = mycalc.nums.joined(separator: " ")
                        }
                    }
                }
            }
        }
    }
    
    //IBAction for Advanced-With History Button
    @IBAction func advanceBtn_Clicked(_ sender: Any) {
        if sender is UIButton{
            if let advance_title = (sender as! UIButton).titleLabel?.text{
                if advance_title == "Advanced - With History"{
                    advanceBtn.setTitle("Standard - No history", for: .normal)
                    resultHistory.isHidden = false
                }
                else{
                    advanceBtn.setTitle("Advanced - With History", for: .normal)
                    resultHistory.isHidden = true
                    resultHistory.text = ""
                }
            }
        }
    }
    
}

