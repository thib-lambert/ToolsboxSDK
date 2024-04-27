// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
		)
	],
	dependencies: [
		.package(url: "https://github.com/realm/SwiftLint.git", .upToNextMajor(from: "0.54.0"))
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(
			name: "ToolsboxSDK_Core",
			dependencies: [],
			plugins: [
				.plugin(name: "SwiftLintPlugin", package: "SwiftLint")
			]
		),
		.target(
			name: "ToolsboxSDK_Network",
			dependencies: [
				"ToolsboxSDK_Core"
			],
			resources: [.copy("Resources/PrivacyInfo.xcprivacy")],
			plugins: [
				.plugin(name: "SwiftLintPlugin", package: "SwiftLint")
			]
		),
		.target(
			name: "ToolsboxSDK_UI",
			dependencies: [],
			plugins: [
				.plugin(name: "SwiftLintPlugin", package: "SwiftLint")
			]
		)
	]
)
