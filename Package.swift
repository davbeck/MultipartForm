// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MultipartForm",
    platforms: [
		.iOS(.v10),
	],
    products: [
        .library(
            name: "MultipartForm",
            targets: ["MultipartForm"]
        ),
    ],
    targets: [
        .target(
            name: "MultipartForm",
            path: "MultipartForm"
        )
    ]
)
