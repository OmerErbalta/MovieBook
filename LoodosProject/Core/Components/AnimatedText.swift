import SwiftUI
struct AnimatedText: View {
    let color: UIColor
    let animationEffect:Int
    let timeInterval:Double
    var characters: [String]
    @State private var currentIndex = 0
    
    init(text: String, color: UIColor,animationEffect:Int,timeInterval:Double) {
        self.color = color
        self.animationEffect = animationEffect
        self.timeInterval = timeInterval
        self.characters = text.map { String($0) }
    }
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(characters.indices, id: \.self) { index in
                Text(characters[index])
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(index <= currentIndex && index+animationEffect > currentIndex ? Color(color) : .white)
                    .offset(x:0,y:index <= currentIndex && index+animationEffect > currentIndex ? 0 :30)
            }
        }
        .onAppear {
            let _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                withAnimation {
                    currentIndex = (currentIndex + 1) % (characters.count + 3)
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
