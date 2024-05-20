//
//  ContentView.swift
//  LoodosProject
//
//  Created by OmerErbalta on 16.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State var NetworkConnetionAlert: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                if NetworkMonitor.isConnectedToNetwork() {
                    SplashView()
                        
                } else {
                    CustomAlert(isActive: $NetworkConnetionAlert, title: "İnternet Bağlantısı", message: "İnternet bağlantınızı kontrol edip tekrar deneyin", buttonTitle: "Tamam") {
                        //button action
                    }
                }
            }
          
        }
    }
}


#Preview {
    ContentView()
}
