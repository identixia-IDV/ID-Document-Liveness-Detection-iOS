// swift-tools-version: 5.9
import PackageDescription

// DocumentReader.xcodeproj keeps linking documentlivenesssdk.framework beside the project.
// This package is the customer install and is not added to that project.
// Replace the zero checksum after publishing documentlivenesssdk.xcframework.zip on GitHub Releases.
let package = Package(
    name: "IdentixiaDocumentReader",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "IdentixiaDocumentReader", targets: ["documentlivenesssdk"])
    ],
    targets: [
        .binaryTarget(
            name: "documentlivenesssdk",
            url: "https://github.com/identixia-IDV/ID-Document-Liveness-Detection-iOS/releases/latest/download/documentlivenesssdk.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        ),
    ]
)
