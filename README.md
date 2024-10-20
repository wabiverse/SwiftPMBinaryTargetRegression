# SwiftPM Regression: Binary Artifact Resolution in C++ Targets ([#8056](https://github.com/swiftlang/swift-package-manager/pull/8056))

### To reproduce

> [!NOTE]
> This does not apply to the SwiftPM **release**, this regression only exists in the `main` branch of SwiftPM.

```swift
git clone git@github.com:wabiverse/SwiftPMBinaryTargetRegression.git
cd SwiftPMBinaryTargetRegression

swift build
```

If you comment out [#1](https://github.com/wabiverse/SwiftPMBinaryTargetRegression/blob/main/Package.swift#L21-L27)
and [#2](https://github.com/wabiverse/SwiftPMBinaryTargetRegression/blob/main/Package.swift#L33-L36),
`swift build`...and toggle them back in...`swift build`, you can reproduce this issue. I've tested against this
[PR](https://github.com/swiftlang/swift-package-manager/pull/8056), and it appears it fixes binary targets to be
resolved from C++ targets.
