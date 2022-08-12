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
        sut = Hangman(guessedWord: "word", guesses: 4)
    }
    
    func test_stateShouldReturnActualStatus() {
        sut = Hangman(guessedWord: "", guesses: 0)
        let result = sut.state().gameStatus
        XCTAssertEqual(result, .inProgress)
    }
    
    func test_stateShouldReturnEqualSizeStringLettersForGussedWord() {
        sut = Hangman(guessedWord: "word", guesses: 0)
        let result = sut.state().letters
        XCTAssertEqual(result, "####")
    }
    
    func test_stateShouldReturnLeftGuessesCount() {
        let result = sut.state().leftGuesses
        XCTAssertEqual(result, 4)
    }
    
    func test_stateShouldReturnUserGuesses() {
        sut.guess("B")
        let result = sut.state().guesses
        XCTAssertEqual(result, "B ")
    }
    
    func test_guessShouldIngoreNumbers() {
        sut.guess("1")
        let result = sut.state().guesses
        XCTAssertEqual(result, "")
    }
    
    func test_guessShouldIngoreStringsWithSizeMoreThan1() {
        sut.guess("bb")
        let result = sut.state().guesses
        XCTAssertEqual(result, "")
    }
    
    func test_guessShouldApproveLowercasesSymbols() {
        sut.guess("b")
        let result = sut.state().guesses
        XCTAssertEqual(result, "B ")
    }

}
