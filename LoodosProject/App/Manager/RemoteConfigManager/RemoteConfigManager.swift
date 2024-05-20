import Foundation
import Firebase

class RemoteConfigManager: ObservableObject {
    static let shared = RemoteConfigManager()
    
    @Published var appName: String = "My App"
    private var remoteConfig: RemoteConfig
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        fetchRemoteConfig()
    }
    func fetchRemoteConfig() {
        remoteConfig.fetchAndActivate { status, error in
            if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                DispatchQueue.main.async {
                    print("Remote config successful")
                    self.appName = self.remoteConfig["AppName"].stringValue ?? "App Name"

                }
            } else {
                print("Fetch failed: \(String(describing: error?.localizedDescription))")
            }
        }
    }
}
