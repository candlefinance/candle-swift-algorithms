// swift-tools-version:5.7
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

import PackageDescription

let package = Package(
    name: "candle-swift-algorithms",
    products: [
        .library(
            name: "CandleAlgorithms",
            targets: ["CandleAlgorithms"]),
    ],
    dependencies: [
        .package(name: "candle-swift-numerics", url: "https://github.com/candlefinance/swift-numerics.git", branch: "fix-candle-1.1.0"),
    ],
    targets: [
        .target(
            name: "CandleAlgorithms",
            dependencies: [
              .product(name: "CandleRealModule", package: "candle-swift-numerics"),
            ]),
        .testTarget(
            name: "SwiftAlgorithmsTests",
            dependencies: ["CandleAlgorithms"]),
    ]
)
