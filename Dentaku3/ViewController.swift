//
//  ViewController.swift
//  Dentaku3
//
//  Created by Kyoko Otsuka on 2016/12/23.
//  Copyright © 2016年 Kyoko Otsuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //ユーザが押した数値
    var InputNum: String = ""
    
    //ユーザが押した演算子
    var InputSym: String = ""
    
    //左項
    var InputL: String = ""
    
    //右項
    var InputR: String = ""
    
    //何も入力されていない時はfalse
    //数値もしくは演算子が押されるとtrueに変わる
    var userInputting: Bool = false
    
    //結果の値
    var resultValue: Double = 0.0
    
    //演算子ボタンを押した後かどうか
    var afterCalc: Bool = false
    
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
        if userInputting == false { //何も入力されていない
            if sender.tag == 0 || sender.tag == 10 { //入力が0か小数点
                return
            } else{ //入力が0か小数点以外
                userInputting = true
                InputNum = (sender.titleLabel?.text)!
            }
        } else {
            InputNum = (sender.titleLabel?.text)!
        }
        
        //項に値を設定
        if afterCalc == false {
            InputL += InputNum
            print(InputL)
        } else {
            InputR += InputNum
            print(InputR)
        }
        //Formulaに出力
        Formula.text = Formula.text! + InputNum
        
    }
    
    //四則演算の入力処理
    @IBAction func Symbol(_ sender: UIButton) {
        
        //前に数値を入力していなかったら演算子は入力できない
        if userInputting == false {
            InputSym = ""
        } else {
            InputSym = (sender.titleLabel?.text)!
        }
        
        afterCalc = true
        Formula.text = Formula.text! + InputSym
        
    }
    
    
    @IBAction func Calculate(_ sender: UIButton) {
        switch InputSym { //演算子によって条件分け
        case "+":
            resultValue = Double(InputL)! + Double(InputR)!
        case "-":
            resultValue = Double(InputL)! - Double(InputR)!
        case "×":
            resultValue = Double(InputL)! * Double(InputR)!
        case "÷":
            if InputR == "0" {
            print("error")
            return
            } else {
            resultValue = Double(InputL)! / Double(InputR)!
            }
        default: break
        }
        
        //結果をresultに表示
        Result.text = String(resultValue)
        
        //初期値に戻す
        afterCalc = false
        userInputting = false
    }
    
    @IBAction func DeleteOne(_ sender: UIButton) {
        //１文字ずつ文字を消す処理
        if afterCalc == false {
            let _InputL :NSMutableString = NSMutableString(string: InputL)
            _InputL.deleteCharacters(in: NSRange(location: _InputL.length - 1, length: 1))
            InputL = String(_InputL)
        } else {
            let _InputR :NSMutableString = NSMutableString(string: InputR)
            _InputR.deleteCharacters(in: NSRange(location: _InputR.length - 1, length: 1))
            InputR = String(_InputR)
            
        }
        let _Formula :NSMutableString = NSMutableString(string: Formula.text!)
        _Formula.deleteCharacters(in: NSRange(location: _Formula.length - 1, length: 1))
        Formula.text = String(_Formula)
    }
    
    
    @IBAction func DeleteAll(_ sender: UIButton) {
        //Cボタンを押すと値入力が一気にクリアされる
        //ただし計算結果は残る
        InputNum = ""
        InputSym = ""
        InputR = ""
        InputL = ""
        userInputting = false
        afterCalc = false
        Formula.text = ""
    }
    
}

