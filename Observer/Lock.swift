//
//  Lock.swift
//  Observer
//
//  Created by roy.cao on 2019/2/2.
//  Copyright © 2019 roy.cao. All rights reserved.
//

import Foundation

public class SpinLock {

    private var unfairLock = os_unfair_lock_s()

    func lock() {
        os_unfair_lock_lock(&unfairLock)
    }

    func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }
}
