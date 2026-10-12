# FlowStudioSDK

FlowStudioSDK runs Bureau Flow Studio flows in your iOS app.

## Requirements

- iOS 15.0 or later
- A Bureau credential ID

## Installation

1. In Xcode, select **File > Add Package Dependencies**.
2. Enter `https://github.com/Bureau-Inc/FlowStudio.git`.
3. Select **Up to Next Major Version** from `0.0.1`.
4. Add the `FlowStudioSDK` product to your app target.

Or add the package to `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Bureau-Inc/FlowStudio.git", from: "0.0.1")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "FlowStudioSDK", package: "FlowStudio")
        ]
    )
]
```

## Permissions

Some flows use device features, such as the camera or the microphone. Add the usage description keys that your flow needs to your app's `Info.plist`, for example `NSCameraUsageDescription` and `NSMicrophoneUsageDescription`. Write each description for your users.

## Execution ID

Your backend creates the execution ID from a Flow Studio journey ID and sends it to your app.

## Usage

```swift
import FlowStudioSDK

let flowStudio = FlowStudio(
    configuration: FlowStudioConfiguration(
        credentialId: "YOUR_CREDENTIAL_ID",
        environment: .production
    )
)

let callback = await flowStudio.start(
    executionId: "EXECUTION_ID",
    presentingController: viewController,
    language: .english
)

switch callback {
case .result(let result):
    print(result.executionId, result.executionStatus?.rawValue ?? "")
case .exit:
    print("User closed the flow")
case .error(let error):
    print("Flow failed: \(error)")
}
```

Call `start` from the main actor. To use a completion handler instead of `await`, use `start(executionId:presentingController:language:animated:completion:)`.

### Options

| Parameter | Values |
|---|---|
| `environment` | `.production`, `.staging` |
| `language` | `.english` (default), `.bahasa` |

### Callback

| Case | Meaning |
|---|---|
| `.result(FlowStudioResult)` | The flow finished. Read `executionStatus` for the outcome. |
| `.exit` | The user closed the flow. |
| `.error(FlowStudioError)` | `.flowAlreadyRunning` or `.presentationFailed`. |

`FlowStudioExecutionStatus` values: `processing`, `awaiting`, `completed`, `timeout`, `error`.
