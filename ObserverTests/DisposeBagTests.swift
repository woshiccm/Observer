//
//  DisposeBagTests.swift
//  ObserverTests
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import XCTest
@testable import Observer

class DisposeBagTests: XCTestCase {

    private class DisposableMock: Disposable {
        private(set) var isDisposed: Bool = false

        func dispose() {
            isDisposed = true
        }
    }

    func testDisposedByObserver() {
        let disoseBag = DisposeBag()
        let variable = Variable<Int>(1)
        var result = [Int]()

        variable
            .subscribe { result.append($0) }
            .dispose(by: disoseBag)
        variable.value = 25

        XCTAssertEqual([1, 25], result)
    }

    func testDisposeOnRelease() {
        var disponsBag: DisposeBag? = DisposeBag()
        let disposable1 = DisposableMock()
        let disposable2 = DisposableMock()
        disposable1.dispose(by: disponsBag!)
        disposable2.dispose(by: disponsBag!)

        disponsBag = nil

        XCTAssertTrue(disposable1.isDisposed)
        XCTAssertTrue(disposable2.isDisposed)
    }
}
