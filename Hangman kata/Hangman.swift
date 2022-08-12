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
    case win
    case lost
}

public class Hangman {
    
    private var guessedWord: String
    private var hiddenWord: String
    private var leftGuesses: Int
    private var userGuesses: String = ""
    private var gameStatus: GameStatus
    
    init(guessedWord: String, guesses: Int) {
        self.guessedWord = guessedWord.uppercased()
        self.leftGuesses = guesses
        self.hiddenWord = guessedWord.hiddenString()
        self.gameStatus = .inProgress
    }
    
    func guess(_ letter: String) {
        guard !letter.isEmpty, letter.count == 1 else {
            return
        }
        
        let capitalizedLetter = letter.capitalized
        
        let range = NSRange(location: 0, length: capitalizedLetter.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[A-Z]")
        if regex.firstMatch(in: capitalizedLetter, range: range) != nil {
            userGuesses += "\(capitalizedLetter) "
            leftGuesses -= 1
            if let letterRange = guessedWord.range(of: capitalizedLetter) {
                hiddenWord = hiddenWord.replacingCharacters(in: letterRange, with: capitalizedLetter)
            }
            
            if !hiddenWord.contains("#") && leftGuesses == 0 {
                gameStatus = .win
            }
        }
    }
    
    func state() -> HangmanState {
        return HangmanState(
            gameStatus: gameStatus,
            letters: hiddenWord,
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
