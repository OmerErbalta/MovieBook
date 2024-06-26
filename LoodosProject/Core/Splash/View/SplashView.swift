//
//  SplashView.swift
//  LoodosProject
//
//  Created by OmerErbalta on 17.05.2024.
//
import SwiftUI

struct SplashView: View {
    @StateObject private var remoteConfigManager = RemoteConfigManager.shared
    @State var showHomePage = false
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: Const.height * 2, height: Const.height * 1)
                    .foregroundColor(Color(uiColor: Const.primaryColor))
                    .rotationEffect(.degrees(45))
                Rectangle()
                    .frame(width: Const.height * 2, height: Const.height * 1)
                    .foregroundColor(Color.white)
                    .rotationEffect(.degrees(45))
            }
            AnimatedText(text: remoteConfigManager.appName, color: Const.primaryColor, animationEffect: 3, timeInterval: 0.3)
                
                .navigationDestination(isPresented: $showHomePage) {
                    AnyView(HomePage().navigationBarBackButtonHidden(true))
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showHomePage = true
            }
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
