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
        sut = Hangman(guessedWord: "", guesses: 0)
    }
    
    func test_stateShouldReturnActualStatus() {
        let result = sut.state().gameStatus
        XCTAssertEqual(result, .inProgress)
    }
    
    func test_stateShouldReturnEqualSizeStringLettersForGussedWord() {
        sut = Hangman(guessedWord: "word", guesses: 0)
        let result = sut.state().letters
        XCTAssertEqual(result, "####")
    }
    
    func test_stateShouldReturnLeftGuessesCount() {
        sut = Hangman(guessedWord: "word", guesses: 4)
        let result = sut.state().leftGuesses
        XCTAssertEqual(result, 4)
    }
    
    func test_stateShouldReturnUserGuesses() {
        sut = Hangman(guessedWord: "word", guesses: 4)
        sut.guess("B")
        let result = sut.state().guesses
        XCTAssertEqual(result, "B ")
    }
    
    

}
