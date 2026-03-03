import ProjectDescription

let project = Project(
    name: "SwikiExampleApp",
    packages: [
        .package(path: "../../")
    ],
    targets: [
        .target(
            name: "SwikiExampleApp",
            destinations: .iOS,
            product: .app,
            bundleId: "io.swiki.example.app",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "Swiki Example",
                "UILaunchScreen": [:],
                "CFBundleURLTypes": [
                    [
                        "CFBundleTypeRole": "Editor",
                        "CFBundleURLSchemes": ["swikiexample"]
                    ]
                ]
            ]),
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "Swiki"),
                .package(product: "SwikiModels"),
                .package(product: "Logging")
            ]
        )
    ]
)
