
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Overview
Observer is a lightweight Swift library for value observing. The core of Observer is the ObservableType and Disposable  protocol.

Observable and Variable implement ObservableType, DisposableObserver implements Disposable.

## Examples

### Observable

Usually you won't be using Observable directly. It is the parent of Variable. It can provide very few functions. You can implement the function you want by inheriting the Observable from the custom class.


```swift
var disposable: Disposable?
let name = Observable<String>()
disposable = name.subscribe { _ in 

}
disposable?.dispose()

```


### Variable
Variable<T> is a simple struct allowing you to have observable variables.

```swift
let sut = Variable<Int>(0)
var result = [Int]()

let disposable = sut.subscribe { 
	print($0)
}
disposable.dispose()

```

**observer Struct propetty**

```swift
struct DummyStruct {
	var number: Int
}

var sut = Variable<DummyStruct>(DummyStruct(number: 0))
let disposable = sut.subscribe { 
	print($0.number) 
}
disposable.dispose()

```

```swift
enum Status {
	case loading
	case empty
	case error(String)
}

struct LogicController {
	var status = Variable<Status>(.loading)
}

var logicController = LogicController()
let disposable = logicController.status.subscribe {
	switch $0 {
	case let .error(str):
		string = str
	default:
	return
	}
}

logicController.status.value = .error("网络断开连接")
disposable.dispose()

```

### Disposable

In order to avoid memory leaks, there are two ways to dispose

```
public protocol Disposable {

    func dispose()
}

extension Disposable {

    public func dispose(by bag: DisposeBag) {
        bag.append(self)
    }
}
```

**dispose()**

```
let sut = Variable<Int>(0)

let disposable = sut.subscribe { 
	print($0)
}
disposable.dispose()
```

**dispose by DisposeBag**

```
let sut = Variable<Int>(0)
let bag = DisposeBag()

let disposable = sut.subscribe {
    print($0)
}.dispose(by: bag)

```


## Installation

#### Carthage
Add the following line to your [Cartfile](https://github.com/carthage/carthage)'

```
git "https://github.com/woshiccm/Observer.git" "master"
```


##License
All this code is released under the MIT license.
