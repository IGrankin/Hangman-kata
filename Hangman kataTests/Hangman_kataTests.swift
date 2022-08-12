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
    
    func test_gameShouldDoNothingWhenUserTryToInputSymbolsAfterLostState() {
        sut.guess("w")
        sut.guess("a")
        sut.guess("l")
        sut.guess("e")
        sut.guess("y")
        let result = sut.state()
        XCTAssertEqual(result.gameStatus, .lost)
        XCTAssertEqual(result.letters, "W###")
        XCTAssertEqual(result.leftGuesses, 0)
        XCTAssertEqual(result.guesses, "W A L E ")
    }
    
    func test_guessOpen2SameSymbols() {
        sut = Hangman(guessedWord: "commit", guesses: 5)
        sut.guess("m")
        let result = sut.state().letters
        XCTAssertEqual(result, "##MM##")
    }
    
    // MARK: - Examples
    
    func test_exampleWithLost() {
        sut = Hangman(guessedWord: "BELL", guesses: 3)
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 3)
        XCTAssertEqual(sut.state().guesses, "")
        
        sut.guess("X")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 2)
        XCTAssertEqual(sut.state().guesses, "X ")
        
        sut.guess("#")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 2)
        XCTAssertEqual(sut.state().guesses, "X ")
        
        sut.guess("BB")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 2)
        XCTAssertEqual(sut.state().guesses, "X ")
        
        sut.guess("L")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "##LL")
        XCTAssertEqual(sut.state().leftGuesses, 1)
        XCTAssertEqual(sut.state().guesses, "X L ")
        
        sut.guess("Y")
        XCTAssertEqual(sut.state().gameStatus, .lost)
        XCTAssertEqual(sut.state().letters, "##LL")
        XCTAssertEqual(sut.state().leftGuesses, 0)
        XCTAssertEqual(sut.state().guesses, "X L Y ")
        
        sut.guess("Z")
        XCTAssertEqual(sut.state().gameStatus, .lost)
        XCTAssertEqual(sut.state().letters, "##LL")
        XCTAssertEqual(sut.state().leftGuesses, 0)
        XCTAssertEqual(sut.state().guesses, "X L Y ")
    }
    
    func test_exampleWithWin() {
        sut = Hangman(guessedWord: "BELL", guesses: 3)
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 3)
        XCTAssertEqual(sut.state().guesses, "")
        
        sut.guess("X")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 2)
        XCTAssertEqual(sut.state().guesses, "X ")
        
        sut.guess("#")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 2)
        XCTAssertEqual(sut.state().guesses, "X ")
        
        sut.guess("BB")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "####")
        XCTAssertEqual(sut.state().leftGuesses, 2)
        XCTAssertEqual(sut.state().guesses, "X ")
        
        sut.guess("L")
        XCTAssertEqual(sut.state().gameStatus, .inProgress)
        XCTAssertEqual(sut.state().letters, "##LL")
        XCTAssertEqual(sut.state().leftGuesses, 1)
        XCTAssertEqual(sut.state().guesses, "X L ")
        
        sut.guess("Y")
        XCTAssertEqual(sut.state().gameStatus, .lost)
        XCTAssertEqual(sut.state().letters, "##LL")
        XCTAssertEqual(sut.state().leftGuesses, 0)
        XCTAssertEqual(sut.state().guesses, "X L Y ")
        
        sut.guess("B")
        XCTAssertEqual(sut.state().gameStatus, .lost)
        XCTAssertEqual(sut.state().letters, "B#LL")
        XCTAssertEqual(sut.state().leftGuesses, 0)
        XCTAssertEqual(sut.state().guesses, "X L Y B ")
        
        sut.guess("E")
        XCTAssertEqual(sut.state().gameStatus, .lost)
        XCTAssertEqual(sut.state().letters, "##LL")
        XCTAssertEqual(sut.state().leftGuesses, 0)
        XCTAssertEqual(sut.state().guesses, "X L Y B E ")
    }
}
