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
    
    func test_oneLetterShouldDecreaseLeftGuessesCount() {
        sut.guess("b")
        let result = sut.state().leftGuesses
        XCTAssertEqual(result, 3)
    }
    
    func test_correctLetterShouldDecreaseLeftGuessesCountAndShowThisLetterInHiddenLetters() {
        sut.guess("w")
        let result = sut.state()
        XCTAssertEqual(result.leftGuesses, 3)
        XCTAssertEqual(result.letters, "W###")
    }
    
    func test_gameShouldHaveWinStateAfterCorrectGuessing() {
        sut.guess("w")
        sut.guess("o")
        sut.guess("r")
        sut.guess("d")
        let result = sut.state()
        XCTAssertEqual(result.gameStatus, .win)
        XCTAssertEqual(result.letters, "WORD")
        XCTAssertEqual(result.leftGuesses, 0)
        XCTAssertEqual(result.guesses, "W O R D ")
    }
    
    func test_gameShouldDoNothingWhenUserTryToInputSymbolsAfterWinState() {
        sut.guess("w")
        sut.guess("o")
        sut.guess("r")
        sut.guess("d")
        sut.guess("d")
        let result = sut.state()
        XCTAssertEqual(result.gameStatus, .win)
        XCTAssertEqual(result.letters, "WORD")
        XCTAssertEqual(result.leftGuesses, 0)
        XCTAssertEqual(result.guesses, "W O R D ")
    }
}
