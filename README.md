# KMM Firebase Authentication API demo using [GitLiveApp/firebase-kotlin-sdk](https://github.com/GitLiveApp/firebase-kotlin-sdk)

Note: This sample project demonstrates how to link KMM apps to the Firebase API. I made this example because I had a lot of trouble getting it to function.

## _This sample project shows how to resolve [KMM](Kotlin Multiplatform Mobile) linking issue_

1.Followed [this document](https://kotlinlang.org/docs/multiplatform-mobile-create-first-app.html#create-the-project-from-a-template) to make the project:
1. Added Fiebase dependenceis on shared/commonMain and implemented FirebaseAuthentication class
3. Implemented androidApp --> This compiles and launches fine. It throws error because FirebaseApp is not initialized. but for this demo, the actual FirebaseApi is functioning on Android
4. iOS throws this error --> ld: framework not found FirebaseAuth
5. Added "isStatic = true" on the Shared gradle. This post helped me with this [https://github.com/GitLiveApp/firebase-kotlin-sdk/issues/288#issuecomment-1126969951]
6. ios Now throws the ff Error:
```
Could not find or use auto-linked framework 'FirebaseAuth'
Could not find or use auto-linked framework 'GoogleUtilities'
Could not find or use auto-linked framework 'FirebaseCore'
Could not find or use auto-linked framework 'GTMSessionFetcher'
Could not find or use auto-linked framework 'FirebaseInstallations'
Could not find or use auto-linked framework 'GoogleAppMeasurement'
Could not find or use auto-linked framework 'GoogleAppMeasurementIdentitySupport'
Could not find or use auto-linked framework 'FirebaseCoreDiagnostics'
Could not find or use auto-linked framework 'GoogleDataTransport'
Could not find or use auto-linked framework 'nanopb'
Could not find or use auto-linked framework 'FirebaseAnalytics'
Could not find or use auto-linked framework 'PromisesObjC'
Undefined symbol: _FIRAuthErrorDomain
Undefined symbol: _OBJC_CLASS_$_FIRUser
Undefined symbol: _OBJC_CLASS_$_FIRMultiFactorSession
Undefined symbol: _OBJC_CLASS_$_FIRPhoneAuthProvider
Undefined symbol: _OBJC_CLASS_$_FIRAuthDataResult
Undefined symbol: _OBJC_CLASS_$_FIRGoogleAuthProvider
Undefined symbol: _OBJC_CLASS_$_FIRMultiFactorInfo
Undefined symbol: _OBJC_CLASS_$_FIREmailAuthProvider
Undefined symbol: _OBJC_CLASS_$_FIRGitHubAuthProvider
Undefined symbol: _OBJC_CLASS_$_FIRFacebookAuthProvider
Undefined symbol: _OBJC_CLASS_$_FIRActionCodeSettings
Undefined symbol: _OBJC_CLASS_$_FIRTwitterAuthProvider
Undefined symbol: _OBJC_CLASS_$_FIRAuth
Undefined symbol: _OBJC_CLASS_$_FIROAuthProvider
Undefined symbol: _OBJC_CLASS_$_FIROptions
Undefined symbol: _OBJC_CLASS_$_FIRActionCodeInfo
Undefined symbol: _OBJC_CLASS_$_FIRAuthTokenResult
Undefined symbol: _OBJC_CLASS_$_FIRApp
```

1. [This tutorial](https://kotlinlang.org/docs/multiplatform-mobile-integrate-in-existing-app.html) lists the ff to link iOS to the shared framework:
```kt
   1. Add the ff script on the iOS buildphase:
      cd "$SRCROOT/.."
      ./gradlew :shared:embedAndSignAppleFrameworkForXcode
   2. Add the following path the Framework serach:
      $(SRCROOT)/../shared/build/xcode-frameworks/$(CONFIGURATION)/$(SDK_NAME)
   3. Add the ff on "Other Linker Flags":
      $(inherited) -framework shared
```
I confirmed the above steps are configured. I'ts configured since I created KMM project from scratched

7. [Adding the Firebased sdk to ios ](https://github.com/GitLiveApp/firebase-kotlin-sdk/issues/288#issuecomment-1109044580) Resolved the above issues 
8. Now I get the ff warnings but app launches and everything works:
```kt
(x86_64)  could not find object file symbol for symbol _kfun:dev.gitlive.firebase.Firebase#<init>(){}
(x86_64)  could not find object file symbol for symbol _kfun:dev.gitlive.firebase.FirebaseException#<init>(kotlin.String){}
(x86_64)  could not find object file symbol for symbol __Konan_init_dev.gitlive:firebase-app
(x86_64)  could not find object file symbol for symbol _kifacetable:dev.gitlive.firebase.Firebase
(x86_64)  could not find object file symbol for symbol _krefs:dev.gitlive.firebase.FirebaseException
(x86_64)  could not find object file symbol for symbol _kifacetable:dev.gitlive.firebase.FirebaseException
(x86_64)  could not find object file symbol for symbol _kextoff:dev.gitlive.firebase.FirebaseException
(x86_64)  could not find object file symbol for symbol _kexttype:dev.gitlive.firebase.FirebaseException
(x86_64)  could not find object file symbol for symbol ___unnamed_36
(x86_64)  could not find object file symbol for symbol ___unnamed_37
(x86_64)  could not find object file symbol for symbol ___unnamed_38
(x86_64)  could not find object file symbol for symbol ___unnamed_39
(x86_64)  could not find object file symbol for symbol ___unnamed_40
(x86_64)  could not find object file symbol for symbol _kclass:dev.gitlive.firebase.Firebase
(x86_64)  could not find object file symbol for symbol _kclass:dev.gitlive.firebase.FirebaseException
(x86_64)  could not find object file symbol for symbol _kextname:dev.gitlive.firebase.FirebaseException
(x86_64)  could not find object file symbol for symbol _kobjref:dev.gitlive.firebase.Firebase
(x86_64)  could not find object file symbol for symbol _ktypew:dev.gitlive.firebase.Firebase
(x86_64)  could not find object file symbol for symbol _ktypew:dev.gitlive.firebase.FirebaseException
```

![#f03c15](https://placehold.co/15x15/f03c15/f03c15.png) `TODO: Make sure to add GoogleService-Info.plist to your project`
