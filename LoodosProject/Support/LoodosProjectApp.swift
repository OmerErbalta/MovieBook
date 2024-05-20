import SwiftUI
import FirebaseCore
import Firebase
import FirebaseMessaging
import FirebaseInAppMessaging
import FirebaseAnalytics

class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        // In-App Messaging initialization
        setupInAppMessaging()
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = fcmToken {
            print("FCM registration token: \(fcm)")
            UserDefaults.standard.set(fcm, forKey: "fcm")
        }
    }
    
    private func setupInAppMessaging() {
        let inAppMessaging = InAppMessaging.inAppMessaging()
        inAppMessaging.messageDisplaySuppressed = false
        inAppMessaging.triggerEvent("some_event")
        
        Analytics.logEvent("inApp_messaging_event", parameters: [
            "name": "inApp_Messaging",
            "full_text": "this is a test event for in-app messaging"
        ])
    }
}

@main
struct LoodosProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
