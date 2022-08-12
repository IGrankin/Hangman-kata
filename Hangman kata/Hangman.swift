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
    var guesses: String
}

public enum GameStatus {
    case inProgress
    case lost
}

public class Hangman {
    
    private var guessedWord: String
    private var leftGuesses: Int
    private var userGuesses: String = ""
    
    init(guessedWord: String, guesses: Int) {
        self.guessedWord = guessedWord.capitalized
        self.leftGuesses = guesses
    }
    
    func guess(_ letter: String) {
        guard !letter.isEmpty, letter.count == 1 else {
            return
        }
        
        let range = NSRange(location: 0, length: letter.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[A-Za-z]")
        if regex.firstMatch(in: letter, range: range) != nil {
            userGuesses += "\(letter.capitalized) "
        }
    }
    
    func state() -> HangmanState {
        return HangmanState(
            gameStatus: .inProgress,
            letters: guessedWord.hiddenString(),
            leftGuesses: leftGuesses,
            guesses: userGuesses
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
