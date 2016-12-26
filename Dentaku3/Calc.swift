//
//  Calc.swift
//  Dentaku3
//
//  Created by Kyoko Otsuka on 2016/12/25.
//  Copyright © 2016年 Kyoko Otsuka. All rights reserved.
//

import Foundation

class Calc {
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
    
    
    //数字と小数点の入力処理
    func makeNum() {
        
        //最初の数値が小数点なら"0."に変換
        if userInputting == false {
            userInputting = true
            if InputNum == "."{
                InputNum = "0."
            }
        }
        
        
        //項に値を設定していく
        //左項
        if afterCalc == false { //1つの項に小数点が複数入らないよう処理
            if InputL.range(of:".") != nil && InputNum == "."{
                InputNum = ""
            }
            
            if InputL == "0" { //最初の値が0なら次桁を追加しない
                if InputNum == "." {//ただし小数点の場合はOK
                    InputL = "0."
                } else {
                    InputL = InputNum
                    print(InputL)
                }
            } else {
                InputL += InputNum
                print(InputL)
            }
        }
            
            
            //右項
        else {
            if InputR.range(of:".") != nil && InputNum == "."{
                InputNum = ""
            }
            
            if InputR == "0" {
                if InputNum == "." {
                    InputR = "0."
                } else {
                InputR = InputNum
                print(InputR)
                }
            } else {
                InputR += InputNum
                print(InputR)
            }
        }
    }
    
    
    func makeSym() {
        //前に数値を入力していなかったら演算子は入力できない
        if userInputting == false {
            InputSym = ""
        }
        afterCalc = true
        userInputting = false
    }
    
    
    
    func makeResult () {
        //演算子によって条件分け
        switch InputSym {
        case "+":
            resultValue = Double(InputL)! + Double(InputR)!
        case "-":
            resultValue = Double(InputL)! - Double(InputR)!
        case "×":
            resultValue = Double(InputL)! * Double(InputR)!
        case "÷":
            if InputR == "0" { //右項が0なら割り算はできない
                print("error")
                return
            } else {
                resultValue = Double(InputL)! / Double(InputR)!
            }
        default: break
        }
        
        //初期値に戻す
        afterCalc = false
        userInputting = false
    }
    
    
    
    func deleteOne() {
        //左項しか入力されていなければ、左項から一字消す
        if afterCalc == false {
            let _InputL :NSMutableString = NSMutableString(string: InputL)
            _InputL.deleteCharacters(in: NSRange(location: _InputL.length - 1, length: 1))
            InputL = String(_InputL)
        }
            
            //右項が入力されていれば、右項から一字消す
        else {
            let _InputR :NSMutableString = NSMutableString(string: InputR)
            _InputR.deleteCharacters(in: NSRange(location: _InputR.length - 1, length: 1))
            InputR = String(_InputR)
            
        }
        
    }
    
    
    
    func deleteAll() {
        //Cボタンを押すと値入力が一気にクリアされる
        //ただし計算結果は残る
        InputR = ""
        InputL = ""
        InputNum = ""
        InputSym = ""
        userInputting = false
        afterCalc = false
    }
    
    
}
