// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Fiber",
    dependencies: [
        .Package(url: "https://github.com/jatoben/CommandLine", "3.0.0-pre1"),
        .Package(url: "https://github.com/Alamofire/Alamofire", "4.5.0")
    ]
)
