// swift-tools-version:5.2
import PackageDescription
let package = Package(
    name: "MyStaticLib",
    products: [
        .library(name: "cartupEventRecoSDK", targets: ["cartupEventRecoSDK"])
    ],
    targets: [
        .target(name: "cartupEventRecoSDK", path: "cartupEventRecoSDK")
    ]
)
