// swift-tools-version:4.0
//
//  Package.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//
import PackageDescription

let package = Package(
    name: "Mormon",

    dependencies: [
        /* Add your package dependencies in here
        .package(url: "https://github.com/AlwaysRightInstitute/cows.git",
                 from: "1.0.0"),
        */
        .package(url: "https://github.com/apple/swift-nio.git", 
                 from: "1.3.1"),
    ],

    targets: [
        .target(name: "Mormon", 
                dependencies: [
                  /* Add your target dependencies in here, e.g.: */
                  // "cows",
                  "NIO",
                  "NIOHTTP1",
                ])
    ]
)
