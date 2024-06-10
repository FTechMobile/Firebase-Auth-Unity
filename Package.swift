// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FBASDK",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library( name: "FBASDK", targets: ["FBASDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.27.0"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", exact: "15.0.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", exact: "7.1.0")
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FBASDK",
        dependencies: [
            .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
            .product(name: "GoogleSignIn", package: "googlesignin-ios"),
            .product(name: "FacebookLogin", package: "facebook-ios-sdk")]
        ),
     
    ]
)
