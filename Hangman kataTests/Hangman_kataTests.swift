//
//  Hangman_kataTests.swift
//  Hangman kataTests
//
//  Created by Игорь Гранкин on 12.08.2022.
//

import XCTest
@testable import Hangman_kata

class Hangman_kataTests: XCTestCase {

    func test_stateShouldReturnEmptyString() {
        let result = Hangman().state()
        XCTAssertEqual(result, "")
    }

}

public class Hangman {
    func state() -> String {
        ""
    }
}
