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
        guard gameStatus == .inProgress else {
            return
        }
        
        let capitalizedLetter = letter.capitalized
        
        if isAppliable(letter: capitalizedLetter) {
            userGuesses += "\(capitalizedLetter) "
            
            let updatedHiddenWord = openIfNeeded(
                letter: capitalizedLetter,
                in: hiddenWord,
                using: guessedWord
            )
            
            if updatedHiddenWord == hiddenWord {
                leftGuesses -= 1
            }
            
            hiddenWord = updatedHiddenWord
            
            gameStatus = updateGameStatus(
                hiddenWord: hiddenWord,
                leftGuesses: leftGuesses,
                previousStatus: gameStatus
            )
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
    
    func updateGameStatus(hiddenWord: String, leftGuesses: Int, previousStatus: GameStatus) -> GameStatus {
        if !hiddenWord.contains("#") {
            return .win
        }
        
        if hiddenWord.contains("#") && leftGuesses == 0 {
            return .lost
        }
        return previousStatus
    }
    
    func openIfNeeded(letter: String, in hiddenWord: String, using guessedWord: String) -> String {
        var updatedHiddenWord = hiddenWord
        
        let textRange = NSRange(location: 0, length: guessedWord.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[\(letter)]")
        let ranges = regex.matches(in: guessedWord, range: textRange)
        
        for textCheckingRange in ranges {
            if let replacementRange = Range(textCheckingRange.range, in: guessedWord) {
                updatedHiddenWord = updatedHiddenWord.replacingCharacters(in: replacementRange, with: letter)
            }
        }
        
        return String(updatedHiddenWord)
    }
    
    func isAppliable(letter: String) -> Bool {
        guard !letter.isEmpty, letter.count == 1 else {
            return false
        }
        
        let range = NSRange(location: 0, length: letter.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[A-Z]")
        return regex.firstMatch(in: letter, range: range) != nil
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
