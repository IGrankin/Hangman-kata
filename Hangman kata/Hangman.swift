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
            leftGuesses -= 1
            
            hiddenWord = openIfNeeded(
                letter: capitalizedLetter,
                in: hiddenWord,
                using: guessedWord
            )
            
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
        if !hiddenWord.contains("#") && leftGuesses == 0 {
            return .win
        }
        
        if hiddenWord.contains("#") && leftGuesses == 0 {
            return .lost
        }
        return previousStatus
    }
    
    func openIfNeeded(letter: String, in hiddenWord: String, using guessedWord: String) -> String {
        if let letterRange = guessedWord.range(of: letter) {
            return hiddenWord.replacingCharacters(in: letterRange, with: letter)
        }
        return hiddenWord
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
