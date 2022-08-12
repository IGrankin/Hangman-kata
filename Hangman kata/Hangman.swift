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
    var leftGuesses: Int
}

public enum GameStatus {
    case inProgress
    case lost
}

public class Hangman {
    
    private var guessedWord: String
    private var leftGuesses: Int
    
    init(guessedWord: String, guesses: Int) {
        self.guessedWord = guessedWord
        self.leftGuesses = guesses
    }
    
    func state() -> HangmanState {
        return HangmanState(
            gameStatus: .inProgress,
            letters: guessedWord.hiddenString(),
            leftGuesses: leftGuesses
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
