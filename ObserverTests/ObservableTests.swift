//
//  ObservableTests.swift
//  ObserverTests
//
//  Created by roy.cao on 2018/12/7.
//  Copyright © 2018 roy.cao. All rights reserved.
//

import XCTest
@testable import Observer

class ObservableTests: XCTestCase {

    var chain: Disposable?

    func testAddObserver() {
        let name = Observable<String>()

        chain = name.subscribe { _ in }
        XCTAssertEqual(name.observers.items.count, 1, "Should add a new observer")

        chain?.dispose()
        XCTAssertEqual(name.observers.items.count, 0, "Should not have observer")
    }
}
