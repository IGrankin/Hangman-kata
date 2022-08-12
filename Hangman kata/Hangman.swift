//
//  Hangman.swift
//  Hangman kata
//
//  Created by Игорь Гранкин on 12.08.2022.
//

import Foundation

public struct HangmanState {
    var gameStatus: GameStatus
}

public enum GameStatus {
    case inProgress
    case lost
}

public class Hangman {
    func state() -> HangmanState {
        return HangmanState(gameStatus: .inProgress)
    }
}
