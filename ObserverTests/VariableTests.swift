//
//  VariableTests.swift
//  ObserverTests
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import XCTest
@testable import Observer

class VariableTests: XCTestCase {

    enum Status {
        case loading
        case empty
        case error(String)
    }

    struct DummyStruct {
        var number: Int
    }

    struct LogicController {
        var status = Variable<Status>(.loading)
    }

    func testInitialValue() {
        let sut = Variable<Int>(0)
        var result = [Int]()

        let disposable = sut.subscribe { result.append($0) }
        defer { disposable.dispose() }

        XCTAssertEqual([0], result)
    }

    func testValueUpdates() {
        let sut = Variable<Int>(0)
        var result = [Int]()
        let disposable = sut.subscribe { result.append($0) }
        defer { disposable.dispose() }

        sut.value = 1
        sut.value = 1
        sut.value = 2
        sut.value = 3

        XCTAssertEqual([0, 1, 1, 2, 3], result)
    }

    func testMultipleSubscribers() {
        let sut = Variable<Int>(0)
        var result1 = [Int]()
        var result2 = [Int]()
        let disposable1 = sut.subscribe { result1.append($0) }
        let disposable2 = sut.subscribe { result2.append($0) }
        defer { disposable1.dispose(); disposable2.dispose() }

        sut.value = 1
        sut.value = 1
        sut.value = 2
        sut.value = 3

        XCTAssertEqual([0, 1, 1, 2, 3], result1)
        XCTAssertEqual([0, 1, 1, 2, 3], result2)
    }

    func testDispose() {
        let sut = Variable<Int>(0)
        var result = [Int]()
        let disposable = sut.subscribe { result.append($0) }

        disposable.dispose()
        sut.value = 1

        XCTAssertEqual([0], result)
    }

    func testDontRetainObserver() {
        let sut = Variable<Int>(0)
        var result = [Int]()
        _ = sut.subscribe { result.append($0) }

        sut.value = 1

        XCTAssertEqual([0], result)
    }

    func testStructChangeValue() {
        var sut = Variable<DummyStruct>(DummyStruct(number: 0))
        var result = [Int]()
        let disposable = sut.subscribe { result.append($0.number) }
        defer { disposable.dispose() }

        sut.value.number = 1

        XCTAssertEqual([0, 1], result)
    }

    func testEnumChangeValue() {
        var logicController = LogicController()
        var string = ""

        let disposable = logicController.status.subscribe {
            switch $0 {
            case let .error(str):
                string = str
            default:
                return
            }
        }
        defer { disposable.dispose() }
        logicController.status.value = .error("网络断开连接")

        XCTAssertEqual(string, "网络断开连接")
    }

    func testChangeNilToNotNil() {
        let expected: Int = 1
        var actual: Int?
        let sut = Variable<Int?>(nil)
        let disposable = sut.subscribe { actual = $0 }
        defer { disposable.dispose() }
        sut.value = expected
        XCTAssertEqual(actual, expected)
    }
}
