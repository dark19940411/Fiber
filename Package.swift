// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Fiber",
    dependencies: [
        .Package(url: "https://github.com/jatoben/CommandLine", "3.0.0-pre1"),
        .Package(url: "https://github.com/Alamofire/Alamofire", majorVersion: 4),
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2),
        .Package(url: "https://github.com/jkandzi/Progress.swift", majorVersion: 0)
    ]
)
