// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "OneEntry",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OneEntryCore",
            targets: ["OneEntryCore", "OneEntryAttribute", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryPages",
            targets: ["OneEntryPages", "OneEntryCore", "OneEntryAttribute", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryForm",
            targets: ["OneEntryForm", "OneEntryCore", "OneEntryAttribute", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryCatalog",
            targets: ["OneEntryCatalog", "OneEntryCore", "OneEntryAttribute", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryAuth",
            targets: ["OneEntryAuth", "OneEntryForm", "OneEntryCore", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryOrders",
            targets: ["OneEntryOrders", "OneEntryForm", "OneEntryAttribute", "OneEntryCore", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryStorage",
            targets: ["OneEntryStorage", "OneEntryCore", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryAttributesSets",
            targets: ["OneEntryAttributesSets", "OneEntryAttribute", "OneEntryCore", "OneEntryShared"]
        ),
        .library(
            name: "OneEntryEvents",
            targets: ["OneEntryShared", "OneEntryCore", "OneEntryEvents", "OneEntryAuth"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/socketio/socket.io-client-swift", .upToNextMinor(from: "16.1.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .sharedRemote(
            version: "1.2.0",
            checksum: "1e02e5ef45bc592833300e12eedecf2aaecd655c44f6a9b78b5e16b2421727d0"
        ),
        .core,
        .pages,
        .attribute,
        .localized,
        .catalog(),
        .auth,
        .form,
        .orders(),
        .storage(),
        .attributesSets(),
        .events(),
        
        .testCore,
        .testAttribute,
        .testCatalog(),
        .testForms(),
        .testAuth(),
        .testOrders(),
        .testStorage(),
        .testAttributesSets(),
        .testPayments(),
        .testEvents(),
    ]
)
// MARK: Kotlin Multiplatform
extension Target {
    static func sharedLocalDebug() -> Target {
        .binaryTarget(
            name: "OneEntryShared",
            path: "../OneEntry/shared/build/XCFrameworks/debug/OneEntryShared.xcframework"
        )
    }
    
    static func sharedLocalRelease() -> Target {
        .binaryTarget(
            name: "OneEntryShared",
            path: "../OneEntry/shared/build/XCFrameworks/release/OneEntryShared.xcframework"
        )
    }
    
    static func sharedRemote(
        version: String,
        checksum: String
    ) -> Target {
        .binaryTarget(
            name: "OneEntryShared",
            url: "https://oneentry.s3.us-east-1.amazonaws.com/kotlin-multiplatform/apple/kmm-sdk-xcframeworks/\(version)/OneEntryShared.zip",
            checksum: checksum
        )
    }
}

// MARK: - Executable
extension Target {
    static var core: Target {
        .target(
            name: "OneEntryCore",
            dependencies: [
                "OneEntryShared"
            ],
            path: "./Sources/Core"
        )
    }
    
    static var attribute: Target {
        .target(
            name: "OneEntryAttribute",
            dependencies: [
                "OneEntryShared",
                "OneEntryCore",
            ],
            path: "./Sources/Attribute"
        )
    }
    
    static var pages: Target {
        .target(
            name: "OneEntryPages",
            dependencies: [
                "OneEntryShared",
                "OneEntryLocalized"
            ],
            path: "./Sources/Pages"
        )
    }
    
    static func catalog() -> Target {
        .target(
            name: "OneEntryCatalog",
            dependencies: [
                "OneEntryShared",
                "OneEntryLocalized"
            ],
            path: "./Sources/Catalog"
        )
    }
    
    static var localized: Target {
        .target(
            name: "OneEntryLocalized",
            dependencies: [
                "OneEntryShared",
                "OneEntryAttribute"
            ],
            path: "./Sources/Localized"
        )
    }
    
    static var auth: Target {
        .target(
            name: "OneEntryAuth",
            dependencies: [
                "OneEntryShared",
                "OneEntryCore",
                "OneEntryForm",
            ],
            path: "./Sources/Auth"
        )
    }
    
    static var form: Target {
        .target(
            name: "OneEntryForm",
            dependencies: [
                "OneEntryShared",
                "OneEntryCore",
            ],
            path: "./Sources/Form"
        )
    }
    
    static func orders() -> Target {
        .target(
            name: "OneEntryOrders",
            dependencies: [
                "OneEntryShared",
                "OneEntryLocalized",
                "OneEntryCore",
                "OneEntryForm",
                "OneEntryAuth"
            ],
            path: "./Sources/Orders"
        )
    }
    
    static func storage() -> Target {
        .target(
            name: "OneEntryStorage",
            dependencies: [
                "OneEntryShared",
                "OneEntryCore",
            ],
            path: "./Sources/Storage"
        )
    }
    
    static func attributesSets() -> Target {
        .target(
            name: "OneEntryAttributesSets",
            dependencies: [
                "OneEntryShared",
                "OneEntryCore"
            ],
            path: "./Sources/AttributesSets"
        )
    }
    
    static func events() -> Target {
        .target(
            name: "OneEntryEvents",
            dependencies: [
                "OneEntryShared",
                
                .product(name: "SocketIO", package: "socket.io-client-swift")
            ],
            path: "./Sources/Events"
        )
    }
}

// MARK: - Testable
extension Target {
    static var testCore: Target {
        .testTarget(
            name: "OneEntryCoreTests",
            dependencies: [
                "OneEntryCore"
            ],
            path: "./Tests/CoreTests",
            resources: [
                .process("../Resources/custom_certificate.p12"),
                .process("../Resources/system_certificate.p12")
            ]
//            linkerSettings: [
//                .unsafeFlags(["-lsqlite3"])
//            ]
        )
    }
    
    static var testAttribute: Target {
        .testTarget(
            name: "OneEntryAttributeTests",
            dependencies: [
                "OneEntryPages",
            ],
            path: "./Tests/AttributeTests",
            resources: [
                .process("../Resources/custom_certificate.p12"),
                .process("../Resources/system_certificate.p12")
            ]
//            linkerSettings: [
//                .unsafeFlags(["-lsqlite3"])
//            ]
        )
    }
    
    static func testCatalog() -> Target {
        .testTarget(
            name: "OneEntryCatalogTests",
            dependencies: [
                "OneEntryCatalog"
            ],
            path: "./Tests/CatalogTests",
            resources: [
                .process("../Resources/custom_certificate.p12"),
                .process("../Resources/system_certificate.p12")
            ]
        )
    }
    
    static func testForms() -> Target {
        .testTarget(
            name: "OneEntryFormTests",
            dependencies: [
                "OneEntryForm",
                "OneEntryAttribute"
            ],
            path: "./Tests/FormTests",
            resources: [
                .process("../Resources/custom_certificate.p12"),
                .process("../Resources/system_certificate.p12")
            ]
        )
    }
    
    static func testAuth() -> Target {
        .testTarget(
            name: "OneEntryAuthTests",
            dependencies: [
                "OneEntryAuth",
                "OneEntryAttribute"
            ],
            path: "./Tests/AuthTests",
            resources: [
                .process("../Resources/custom_certificate.p12"),
                .process("../Resources/system_certificate.p12")
            ]
        )
    }
    
    static func testOrders() -> Target {
        .testTarget(
            name: "OneEntryOrdersTests",
            dependencies: [
                "OneEntryOrders",
                "OneEntryCatalog"
            ],
            path: "./Tests/OrdersTests",
            resources: [
                .process("../Resources/custom_certificate.p12"),
                .process("../Resources/system_certificate.p12")
            ]
        )
    }
    
    static func testStorage() -> Target {
        .testTarget(
            name: "OneEntryStorageTests",
            dependencies: [
                "OneEntryStorage"
            ],
            path: "./Tests/StorageTests"
        )
    }
    
    static func testAttributesSets() -> Target {
        .testTarget(
            name: "OneEntryAttributesSetsTests",
            dependencies: [
                "OneEntryAttributesSets"
            ],
            path: "./Tests/AttributesSetsTests"
        )
    }
    
    static func testPayments() -> Target {
        .testTarget(
            name: "OneEntryPaymentTests",
            dependencies: [
                "OneEntryShared",
                "OneEntryAuth",
            ],
            path: "./Tests/PaymentTests"
        )
    }
    
    static func testEvents() -> Target {
        .testTarget(
            name: "OneEntryEventsTests",
            dependencies: [
                "OneEntryShared",
                "OneEntryEvents",
                "OneEntryCatalog",
                "OneEntryAuth"
            ],
            path: "./Tests/EventsTests"
        )
    }
}
