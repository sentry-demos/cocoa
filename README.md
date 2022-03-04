# Cocoa/iOS Demo
sdk 7.2.2
## Setup

In **XCode**:

Select th sentry-cocoa root folder to open the app profile:

1. Set a `SENTRY_AUTH_TOKEN` in 'Run Script' build phase.

2. Put your DSN key in `sentry-cocoa/AppDelegate.swift`

2. sentry-cli must be installed at /usr/local/bin

3. XCode Edit Schemes > 'Run' action for your scheme > Info tab > uncheck 'Debug executable' box.  
This ensures your app doesn't run in debugging mode, in which case unhandled exceptions won't send to Sentry.

3. Run `pod install` from the terminal

4. Click the Run/play button targeting iPhone 11

4. In **Simulator**, Launch the sentry-cocoa app

5. Press a button to generate an Error

## How to Upgrade SDK
Check out a new branch so you can open a PR.    
1. Xcode -> Podfile, increment the sdk version.
2. `pod update`, or `pod install` if pod updating is hanging.
2. Click 'Play' button

## Flow/Demo

The demo app enriches every event with: Custom context, breadcrumbs, tags, user IP, extra data.

1. From the Simulator explicitly send an event to Sentry by clicking
    - **Handled Exception**
    - **Capture Message**

![Send Message](cocoa-send-message.gif)

2. For Native crashes click:

- **Crash Application**
- **UnHandled Exception**

![Native Crash / Runtime Error](cocoa-native-crash.gif)

3. Release:

- Note that the cocoa-sdk automatically creates a Release by using the build version + dist as described in the Android SDK [Release Version Format](https://docs.sentry.io/platforms/android/#release-version-format) 
- The SDK then automatically tags every event with that release version id (i.e. there is no need to explicitly set the release version ID, unless you're explicitly setting a custom release name)

4. Run Scripts:
    
    Upload the Debug Symbols to the target project and associate the commits to the release object.

5. Check for User Feedback collected by the Capture Message and Unhandled Exception buttons

## Documentation/Resources

https://docs.sentry.io/clients/cocoa/

If you still enter debugging mode by accident, then click 'Stop' which will detach the debugger, then re-launch the app from the touch screen. Do not click 'Play' again or else the debugger will re-attach.

CrashApplication button makes "EXC_BAD_INSTRUCTION: Fatal error > procpath"

UnhandledException button makes "EXC_BAD_ACCESS:causeCrash: > crash > Attempted to derefer"

Crashes and unhandled exceptions will have stack traces for several threads. Messages and Handled exceptions will have stack trace for top-level thread.
