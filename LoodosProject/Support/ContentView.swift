//
//  ContentView.swift
//  LoodosProject
//
//  Created by OmerErbalta on 16.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State var NetworkConnetionAlert: Bool = false
    @State var showHomePage = false
    
    var body: some View {
        VStack {
            if NetworkMonitor.isConnectedToNetwork() {
               SplashView()
                   .onAppear {
                       DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                           showHomePage = true
                       }
                   }
                   .fullScreenCover(isPresented: $showHomePage) {
                       HomePage()
                   }
            } else {
                CustomAlert(isActive: $NetworkConnetionAlert, title: "İnternet Bağlantısı", message: "İnternet bağlantınızı kontrol edip tekrar deneyin", buttonTitle: "Tamam") {
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
