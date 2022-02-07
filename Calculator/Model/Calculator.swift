//
//  Calculator.swift
//  Calculator
//
//  Created by Vrushank on 2022-01-30.
//

import Foundation

class Calculator{
    var nums : [String] = []
    var result:Int? //Optional -> can be nil or not
    var operator_error = false
    
    func push(s : String){
        nums.append(s)
        
        //Validation for operator and operand
        for i in 0...nums.count-1{
            if(i % 2 != 0) {
                if(nums[i] == "+" || nums[i] == "-" || nums[i] == "/" || nums[i] == "*"){
                    operator_error = false
                }
                else{
                    operator_error = true
                }
            }
            else{
                if(nums[i] == "+" || nums[i] == "-" || nums[i] == "/" || nums[i] == "*"){
                    operator_error = true
                }
            }
        }
    }
    
    func calc() -> Int {
        
        //Calculation in left-to-right order
        
        var calc_nums = 0
        var index_init = 0
        var index_end = 2
        let calc_range = (nums.count / 2) - 1
        
        if(operator_error != true){
            //Array count would be odd for the successful calculation
            if(nums.count % 2 != 0){
                for i in 0...calc_range{
                    //For first calculation
                    if i==0{
                        //Getting first 3 elements from array
                        let array_slice = nums[index_init...index_end]
                        let result_nums = array_slice.joined(separator: " ")
                        let exp: NSExpression = NSExpression(format: result_nums)
                        let result: Int? = exp.expressionValue(with:nil, context: nil) as? Int
                        calc_nums = result!
                        
                        index_init = index_end + 1
                        index_end += 2
                    }
                    else{
                        // Getting 2 succedding elements from array
                        var array_slice : [String] = [String(calc_nums)]
                        array_slice  += nums[index_init...index_end]
                        let result_nums = array_slice.joined(separator: " ")
                        let exp: NSExpression = NSExpression(format: result_nums)
                        let result: Int? = exp.expressionValue(with:nil, context: nil) as? Int
                        
                        calc_nums = result!
                        index_init = index_end + 1
                        index_end += 2
                    }
                }
                result = calc_nums
            }
        }
        else{
            print("Operator Error!")
        }

        
        if let final_result = result{ //Optional binding -> using let
//            print("The result of \(result_nums) is \(final_result)")
            return final_result
        }
        else{
//          print("Unexpected error!")
            return 0
        }
    }
}
