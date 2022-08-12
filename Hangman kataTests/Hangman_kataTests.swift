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
        sut = Hangman(guessedWord: "")
    }
    
    func test_stateShouldReturnActualStatus() {
        let result = sut.state().gameStatus
        XCTAssertEqual(result, .inProgress)
    }
    
    func test_stateShouldReturnEqualSizeStringLettersForGussedWord() {
        sut = Hangman(guessedWord: "word")
        let result = sut.state().letters
        XCTAssertEqual(result, "####")
    }
    
    func test_stateShouldReturnLeftGuesses() {
        sut = Hangman(guessedWord: "word", guesses: 4)
        let result = sut.state().leftGuesses
        XCTAssertEqual(result, 4)
    }

}
