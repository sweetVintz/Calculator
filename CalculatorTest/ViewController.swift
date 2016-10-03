//
//  ViewController.swift
//  CalculatorTest
//
//  Created by 白菜哥 on 16/9/6.
//  Copyright © 2016年 白菜哥. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    var isTaping = false
    var equalSignTouched = false;

    //MARK: 点击数字
    //逻辑说明: 1.点击键盘上的键，进行判断，如果正在输入计算数值就继续保持输入，在label里显示，如果不是便跳出;2.如果上一次已经完成，继续进行输入的话需要先清空数组里面的数据
    @IBAction func appendDigit(sender: UIButton){
        
        let digit = sender.currentTitle!
        //如果没有运算符的记录就清除数组数据
        if operateId == "" {
            
            appendStack.removeAll()
        }

        if isTaping && display.text! != "0"{
        
            display.text = display.text! + digit
        }
        else{
            isTaping = true
            display.text = digit
        }
    }
    
    var operateId:String = ""
    //MARK: 点击运算符
    //逻辑说明：记录用户所点击的运算符，调用运算方法进行运算判断
    @IBAction func operate(sender: UIButton) {
        
        if operateId == "" {
            
            operateId = sender.currentTitle!
            enter()
        }
        else{
            
            enter()
            operateId = sender.currentTitle!
        }

    
    }
    func performOperation(operation: (Double, Double)->Double) {
        
        if appendStack.count >= 2{
            
            displayValue = operation(appendStack.removeLast() ,appendStack.removeLast())
            appendStack.removeAll()
            appendStack.append(displayValue)
            operateId = ""
        }
    }
    func performOperationSingle(operation: Double->Double) {
        
        if appendStack.count >= 1{
            
            displayValue = operation(appendStack.removeLast())
            appendStack.removeAll()
            appendStack.append(displayValue)
            operateId = ""
        }
    }
    
    var appendStack = Array<Double>()
    var displayValue :Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            
        }
    }
    
    //MARK: 点击等号
    @IBAction func enter() {

        if isTaping{
            
            appendStack.append(displayValue)
            
        }
        isTaping = false
        print("operateId = \(operateId)")
        print("appendStack = \(appendStack)")
        switch operateId {
            
        case "×":performOperation{ $0 * $1 }
        case "÷":performOperation{ $1 / $0 }
        case "+":performOperation{ $0 + $1 }
        case "−":performOperation{ $1 - $0 }
        case "√":performOperationSingle{ sqrt($0) }
            
        default:
            break
        }
    }
    @IBAction func replaceAll() {
        
        appendStack.removeAll()
        isTaping = false
        operateId = ""
        displayValue = 0
        display.text = "0"
    }
    
    @IBAction func sweetTest() {
        
        var arr = Array(arrayLiteral: "s")
        let s = String("addc")
        
        
        //arr.removeLast()
        print("\(s)")
        
    }
}
