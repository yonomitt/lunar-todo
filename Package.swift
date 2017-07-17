// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "todo-moonshot",
    dependencies: [
        .Package(url: "https://github.com/bermudadigitalstudio/Titan.git", Version("0.7.2")),
        .Package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", majorVersion: 0, minor: 5),
        .Package(url: "https://github.com/bermudadigitalstudio/Rope.git", Version("0.5.1"))
    ]
)
