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
    var InputL: Double = 0.0
    
    //右項
    var InputR: Double = 0.0
    
    //何も入力されていない時はfalse
    //数値もしくは演算子が押されるとtrueに変わる
    var userInputting: Bool = false
    
    //InputLが入っているかどうか
    var isStacked: Bool = false
    
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
            InputNum = Formula.text!
            InputNum += (sender.titleLabel?.text)!
        }
//        
//        if afterCalc == false {
//            InputL = Double (InputNum + (sender.titleLabel?.text)!)!
//        }
        //Formulaに出力
        Formula.text = InputNum
    }
    
    //四則演算の入力処理
    @IBAction func Symbol(_ sender: UIButton) {
        
        //前に数値を入力していなかったら演算子は入力できない
        if userInputting == false {
            InputSym = ""
        } else {
            InputSym = (sender.titleLabel?.text)!
        }
        
        Formula.text = InputNum + InputSym
        
        
    }
    
    
    @IBAction func Calculate(_ sender: UIButton) {
        //        switch InputSym {
        //        case "+":
        //            stackedValue += Result
        //        }
    }
    
    
    
    
}

