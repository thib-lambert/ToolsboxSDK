// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
	name: "ToolsboxSDK",
	platforms: [
		.iOS("14.0")
	],
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "ToolsboxSDK_Network",
			targets: [ "ToolsboxSDK_Network"]
		),
		.library(
			name: "ToolsboxSDK_Core",
			targets: [ "ToolsboxSDK_Core"]
		),
		.library(
			name: "ToolsboxSDK_UI",
			targets: [ "ToolsboxSDK_UI"]
		),
		.library(
			name: "ToolsboxSDK_Helpers",
			targets: ["ToolsboxSDK_Helpers"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/realm/SwiftLint.git", from: "0.55.0")
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(
			name: "ToolsboxSDK_Core",
			swiftSettings: [
				.unsafeFlags(["-warnings-as-errors"])
			]
		),
		.target(
			name: "ToolsboxSDK_Network",
			dependencies: [
				"ToolsboxSDK_Core"
			],
			resources: [.copy("Resources/PrivacyInfo.xcprivacy")],
			swiftSettings: [
				.unsafeFlags(["-warnings-as-errors"])
			],
			plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
		),
		.target(
			name: "ToolsboxSDK_UI",
			swiftSettings: [
				.unsafeFlags(["-warnings-as-errors"])
			],
			plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
		),
		.target(
			name: "ToolsboxSDK_Helpers",
			swiftSettings: [
				.unsafeFlags(["-warnings-as-errors"])
			],
			plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
		),
	]
)
