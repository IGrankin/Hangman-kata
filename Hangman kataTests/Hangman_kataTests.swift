//
//  Hangman_kataTests.swift
//  Hangman kataTests
//
//  Created by Игорь Гранкин on 12.08.2022.
//

import XCTest
@testable import Hangman_kata

class Hangman_kataTests: XCTestCase {
    
    var sut: Hangman!
    
    override func setUp() {
        super.setUp()
        sut = Hangman()
    }
    
    func test_stateShouldReturnActualStatus() {
        let result = sut.state().gameStatus
        XCTAssertEqual(result, .inProgress)
    }

}

struct HangmanState {
    var gameStatus: GameStatus
}

enum GameStatus {
    case inProgress
}

public class Hangman {
    func state() -> HangmanState {
        return HangmanState(gameStatus: .inProgress)
    }
}
