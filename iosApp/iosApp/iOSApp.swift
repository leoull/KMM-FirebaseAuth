import SwiftUI
import Firebase

//TODO: Make sure to add GoogleService-Info.plist to your project

/**
 * Firebase Auth demo for KMM
 * Firebase Config doc: https://firebase.google.com/docs/android/setup#add-config-file
 */
@main
struct iOSApp: App {
    init() {
        /*
         * Configure iOS Firebase
         * If you don't configure it, you will get the ff exception:
         * Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'The default
         * FirebaseApp instance must be configured before the default Authinstance can be initialized. One way
         * to ensure this is to call `FirebaseApp.configure()` in the App Delegate's
         * `application(_:didFinishLaunchingWithOptions:)` (or the `@main` struct's initializer in SwiftUI).'
         */
        FirebaseApp.configure()
    }
    
	var body: some Scene {
		WindowGroup {
			ContentView()
        }
	}
}
