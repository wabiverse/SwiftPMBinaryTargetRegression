// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "SwiftPMBinaryTargetRegression",
  platforms: [
    .macOS(.v14),
    .visionOS(.v1),
    .iOS(.v14),
    .tvOS(.v14),
    .watchOS(.v9),
  ],
  dependencies: [
    .package(url: "https://github.com/wabiverse/MetaversePythonFramework", from: "3.11.7")
  ],
  targets: [

    .target(
      name: "TestMeSwift",
      dependencies: [
        .product(name: "Python", package: "MetaversePythonFramework")
      ]
    ),

    // 1. comment this c++ target out, otherwise swiftpm cannot resolve the binary target.
    // https://github.com/swiftlang/swift-package-manager/pull/8056
    .target(
      name: "TestMe",
      dependencies: [
        .product(name: "Python", package: "MetaversePythonFramework")
      ]
    ),
    // ----------------------------------------------

    .testTarget(
      name: "TestMeTests",
      dependencies: [
        "TestMeSwift",
        // 2. comment this c++ target out, otherwise swiftpm cannot resolve the binary target.
        // https://github.com/swiftlang/swift-package-manager/pull/8056
        "TestMe",
        // ----------------------------------------------
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
  ]
)
