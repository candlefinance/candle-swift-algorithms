//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Algorithms open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

/// A collection wrapper that iterates over the indices and elements of a
/// collection together.
public struct IndexedCollection<Base: Collection> {
  /// The base collection.
  internal let base: Base
  
  internal init(base: Base) {
    self.base = base
  }
}

extension IndexedCollection: Collection {
  /// The element type for an `IndexedCollection` collection.
  public typealias Element = (index: Base.Index, element: Base.Element)
  
  public var startIndex: Base.Index {
    base.startIndex
  }
  
  public var endIndex: Base.Index {
    base.endIndex
  }
  
  public subscript(position: Base.Index) -> Element {
    (index: position, element: base[position])
  }
  
  public func index(after i: Base.Index) -> Base.Index {
    base.index(after: i)
  }
  
  public func index(_ i: Base.Index, offsetBy distance: Int) -> Base.Index {
    base.index(i, offsetBy: distance)
  }
  
  public func index(
    _ i: Base.Index,
    offsetBy distance: Int,
    limitedBy limit: Base.Index
  ) -> Base.Index? {
    base.index(i, offsetBy: distance, limitedBy: limit)
  }
  
  public func distance(from start: Base.Index, to end: Base.Index) -> Int {
    base.distance(from: start, to: end)
  }
  
  public var indices: Base.Indices {
    base.indices
  }
}

extension IndexedCollection: BidirectionalCollection
  where Base: BidirectionalCollection
{
  public func index(before i: Base.Index) -> Base.Index {
    base.index(before: i)
  }
}

extension IndexedCollection: RandomAccessCollection
  where Base: RandomAccessCollection {}

extension IndexedCollection: LazySequenceProtocol, LazyCollectionProtocol
  where Base: LazySequenceProtocol {}

//===----------------------------------------------------------------------===//
// indexed()
//===----------------------------------------------------------------------===//

extension Collection {
  /// Returns a collection of pairs *(i, x)*, where *i* represents an index of
  /// the collection, and *x* represents an element.
  ///
  /// The `indexed()` method is similar to the standard library's `enumerated()`
  /// method, but provides the index with each element instead of a zero-based
  /// counter.
  ///
  /// This example iterates over the indices and elements of a set, building an
  /// array consisting of indices of names with five or fewer letters.
  ///
  ///     let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
  ///     var shorterIndices: [Set<String>.Index] = []
  ///     for (i, name) in names.indexed() {
  ///         if name.count <= 5 {
  ///             shorterIndices.append(i)
  ///         }
  ///     }
  ///
  /// - Returns: A collection of paired indices and elements of this collection.
  public func indexed() -> IndexedCollection<Self> {
    IndexedCollection(base: self)
  }
}
