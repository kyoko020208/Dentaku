//
//  ViewController.swift
//  Dentaku3
//
//  Created by Kyoko Otsuka on 2016/12/23.
//  Copyright © 2016年 Kyoko Otsuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let calc = Calc()
    
    @IBOutlet weak var Formula: UITextField!
    
    @IBOutlet weak var Result: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //数字と小数点の入力処理
    //タグ番号は入力値と同じ（小数点はタグ:0)
    @IBAction func Number(_ sender: UIButton) {
        calc.InputNum = (sender.titleLabel?.text)!
        calc.makeNum()
        
        //Formulaに出力
        if calc.InputL == "0" {
            if calc.InputNum != "." { //"01"のような出力を避ける
                Formula.text = calc.InputNum
            }
        } else if calc.InputR == "0" {
            if calc.InputNum != "." {
                Formula.text = calc.InputL + calc.InputSym + calc.InputNum
            }
        } else {
            Formula.text = calc.InputL + calc.InputSym + calc.InputR
        }
    }
    
    
    //四則演算の入力処理
    @IBAction func Symbol(_ sender: UIButton) {
        calc.InputSym = (sender.titleLabel?.text)!
        calc.makeSym()
        Formula.text = Formula.text! + calc.InputSym
        
    }
    
    
    @IBAction func Calculate(_ sender: UIButton) {
        calc.makeResult()
        Result.text = String(calc.resultValue)
    }
    
    @IBAction func DeleteOne(_ sender: UIButton) {
        
        //式から1字消す
        let _Formula :NSMutableString = NSMutableString(string: Formula.text!)
        _Formula.deleteCharacters(in: NSRange(location: _Formula.length - 1, length: 1))
        Formula.text = String(_Formula)
    }
    
    
    @IBAction func DeleteAll(_ sender: UIButton) {
        //式を全クリア
        Formula.text = ""
    }
    
}

