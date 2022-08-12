//
//  Hangman.swift
//  Hangman kata
//
//  Created by Игорь Гранкин on 12.08.2022.
//

import Foundation

public struct HangmanState {
    var gameStatus: GameStatus
    var letters: String
}

public enum GameStatus {
    case inProgress
    case lost
}

public class Hangman {
    
    private var guessedWord: String
    
    init(guessedWord: String) {
        self.guessedWord = guessedWord
    }
    
    func state() -> HangmanState {
        return HangmanState(
            gameStatus: .inProgress,
            letters: guessedWord.hiddenString()
        )
    }
}

extension String {
    func hiddenString() -> String {
        var hiddenString = ""
        for _ in 0..<self.count {
            hiddenString.append("#")
        }
        return hiddenString
    }
}
