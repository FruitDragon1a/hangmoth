//
//  Game.swift
//  hangmoth
//
//  Created by Fruit Dragon on 3/27/24.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character] = [" ", "-"]
    let aAccents : [Character] = ["à", "á", "â", "ä", "ǎ", "æ", "ã", "å", "ā"]
    let eAccents : [Character] = ["è", "é", "ê", "ë", "ě", "ẽ", "ē", "ė", "ę"]
    let iAccents : [Character] = ["í", "î", "ï", "í", "ǐ", "ĩ", "ī", "ı", "į"]
    let oAccents : [Character] = ["ò", "ó", "ô", "ö", "ǒ", "œ", "ø", "õ", "ō"]
    let uAccents : [Character] = ["ù", "ú", "û", "ü", "ǔ", "ũ", "ū", "ű", "ů"]
   
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) || letter == " " || letter == "-" {
                guessedWord += "\(letter)"
            } else if guessedLetters.contains("a") && aAccents.contains(letter){
                guessedWord += "\(letter)"
            } else if guessedLetters.contains("e") && eAccents.contains(letter){
                guessedWord += "\(letter)"
            } else if guessedLetters.contains("i") && iAccents.contains(letter){
                guessedWord += "\(letter)"
            } else if guessedLetters.contains("o") && oAccents.contains(letter){
                guessedWord += "\(letter)"
            } else if guessedLetters.contains("u") && uAccents.contains(letter){
                guessedWord += "\(letter)"
            }
            else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
        
    }
    
}
