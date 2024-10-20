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
  dependencies: Arch.getPackageDeps(),
  targets: [

    .target(
      name: "TestMeSwift",
      dependencies: Arch.add(dependency: .python)
    ),

    // 1. comment this c++ target out, otherwise swiftpm cannot resolve the binary target.
    // https://github.com/swiftlang/swift-package-manager/pull/8056
    .target(
      name: "TestMe",
      dependencies: Arch.add(dependency: .python)
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
  ] + Arch.add(system: .python)
)

enum Arch {
  enum Dependency {
    case python
  }

  public static func add(dependency: Dependency) -> [Target.Dependency] {
    switch dependency
    {
    case .python:
      #if os(macOS) || os(visionOS) || os(iOS) || os(tvOS) || os(watchOS)
        [.product(name: "Python", package: "MetaversePythonFramework")]
      #else
        [.target(name: "Python")]
      #endif
    }
  }

  public static func getPackageDeps() -> [Package.Dependency] {
    #if os(macOS) || os(visionOS) || os(iOS) || os(tvOS) || os(watchOS)
      [.package(url: "https://github.com/wabiverse/MetaversePythonFramework", from: "3.11.7")]
    #else
      []
    #endif
  }

  public static func add(system: Dependency) -> [Target] {
    #if os(macOS) || os(visionOS) || os(iOS) || os(tvOS) || os(watchOS)
      []
    #else
      [
        .systemLibrary(
          name: "Python",
          pkgConfig: "python3",
          providers: [
            .apt(["python3-dev"]),
            .yum(["python3-devel"]),
          ]
        )
      ]
    #endif
  }
}
