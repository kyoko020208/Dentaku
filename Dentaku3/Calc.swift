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
    
    //項 (一つの式で入力できるのは3項まで)
    var numbersString: [String] = ["", "", ""]
    
    //演算子（一つの式で入力できる演算子は2つまで)
    var symbolsString: [String] = ["", ""]
    
    //項と演算子の番号
    var i:Int = 0
    
    //何も入力されていない時はfalse
    //数値もしくは演算子が押されるとtrueに変わる
    var userInputting: Bool = false
    
    //最初の2項の計算結果
    var subResultValue: Double = 0.0
    
    //結果の値
    var resultValue: Double = 0.0
    
    
    //数字と小数点の入力処理
    func makeNum() {
        
        //桁あふれ処理のため、数字の長さをlenに格納
        let len: Int = numbersString[i].characters.count
        
        //入力できるのは3項まで
        if i < 3 {
            
            //最初の数値が小数点なら"0."に変換
            if userInputting == false {
                userInputting = true
                if InputNum == "."{
                    InputNum = "0."
                }
            }
            
            
            //1つの項に小数点が複数入らないよう処理
            if numbersString[i].range(of:".") != nil && InputNum == "."{
                InputNum = ""
            }
            
            if numbersString[i] == "0" { //最初の値が0なら次桁を追加しない
                if InputNum == "." {//ただし小数点の場合はOK
                    numbersString[i] = "0."
                } else {
                    numbersString[i] = InputNum
                    print(numbersString[i])
                }
            } else if len < 7 { //6桁もう入っていれば、新たに数値は入力できない
                numbersString[i] += InputNum
                print(numbersString[i])
            }
        } else {
            InputNum = ""
        }
    }
    
    
    func makeSym() {
        
        if i < 2 {
            //前に数値を入力していなかったら演算子は入力できない
            if userInputting == false {
                InputSym = ""
            } else {
                symbolsString[i] = InputSym
                userInputting = false
                i += 1
            }
        } else {
            InputSym = ""
        }
    }
    
    
    
    
    func Operations (currentSym: String, X: String, Y: String) -> Double{
        
        switch currentSym {
        case "+":
            return Double(X)! + Double(Y)!
        case "-":
            return Double(X)! - Double(Y)!
        case "×":
            return Double(X)! * Double(Y)!
        case "÷":
            if Y == "0" { //右項が0なら割り算はできない
                print("error")
                return 0.0
            } else {
                return Double(X)! / Double(Y)!
            }
        default: return 0.0
        }
    }
    
    
    
    func makeResult () {
        //演算子によって条件分け
        if i == 2 { //項が3つある場合
            if symbolsString[1] == "×" || symbolsString[1] == "÷"{ //2つ目の演算子が"×"か"÷"ならば
                //先に項2と項3を計算→subResultValueに格納
                subResultValue = Operations(currentSym: symbolsString[1], X: numbersString[1] , Y: numbersString[2])
                resultValue = Operations(currentSym: symbolsString[0], X: numbersString[0], Y: String(subResultValue))
            } else {
                subResultValue = Operations(currentSym: symbolsString[0], X: numbersString[0], Y: numbersString[1])
                resultValue = Operations(currentSym: symbolsString[1], X: String(subResultValue), Y: numbersString[2])
            }
        } else if i == 1 { //項が2つのみの場合
            resultValue = Operations(currentSym: symbolsString[0], X: String(numbersString[0]), Y: numbersString[1])
        } else {
            resultValue = Double(numbersString[0])!
        }
        userInputting = false
    }
    
    
    func deleteNumber() {
        let _numbersString :NSMutableString = NSMutableString(string: numbersString[i])
        _numbersString.deleteCharacters(in: NSRange(location: _numbersString.length - 1, length: 1))
        numbersString[i] = String(_numbersString)
    }
    
    func deleteSymbol() {
        symbolsString[i-1] = ""
        i = i - 1
        userInputting = true
    }
    
    
    func deleteAll() {
        //Cボタンを押すと値入力が一気にクリアされる
        //ただし計算結果は残る
        InputNum = ""
        InputSym = ""
        for i in 0...1 {
            numbersString[i] = ""
            symbolsString[i] = ""
            numbersString[2] = ""
            print(numbersString[i])
        }
        userInputting = false
        i = 0
    }
    
    
}
