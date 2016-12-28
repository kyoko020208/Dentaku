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
        Formula.text = calc.numbersString[0] + calc.symbolsString[0] + calc.numbersString[1] + calc.symbolsString[1] + calc.numbersString[2]
    }
    
    
    //四則演算の入力処理
    @IBAction func Symbol(_ sender: UIButton) {
        calc.InputSym = (sender.titleLabel?.text)!
        calc.makeSym()
        
        //Formulaに出力
        Formula.text = Formula.text! + calc.InputSym
    }
    
    
    @IBAction func Calculate(_ sender: UIButton) {
        calc.makeResult()
        
        //Resultに出力(小数点以下は切り捨て
        Result.text = String(Int(calc.resultValue))
    }
    
    
    @IBAction func DeleteOne(_ sender: UIButton) {
        
        //Formulaに出力されている文字列を１文字ずつに分解
        let _Formula :NSMutableString = NSMutableString(string: Formula.text!)
        
        //「+, -, *, /」をUNint32に変換
        let plus: UInt32 = (String("+")?.unicodeScalars.first!.value)!
        let minus: UInt32 = (String("-")?.unicodeScalars.first!.value)!
        let kakeru: UInt32 = (String("×")?.unicodeScalars.first!.value)!
        let waru: UInt32 = (String("÷")?.unicodeScalars.first!.value)!
        
        //Formulaに出力されている文字列の最後の文字をFINに格納
        let FIN: UInt32 = UInt32(_Formula.character(at: _Formula.length-1))
        
        //Formulaの文字列の最後の文字が演算子ならdeleteSymbolを実行
        if  plus == FIN || minus == FIN || kakeru == FIN || waru == FIN {
            calc.deleteSymbol()
        } else { //最後の文字が数字ならdeleteNumberを実行
            calc.deleteNumber()
        }
        
        //Formulaの文字列からも１文字削除して、出力し直す
        _Formula.deleteCharacters(in: NSRange(location: _Formula.length - 1, length: 1))
        Formula.text = String(_Formula)
    }
    
    
    @IBAction func DeleteAll(_ sender: UIButton) {
        
        //全クリア
        calc.deleteAll()
        Formula.text = ""
    }
    
}

