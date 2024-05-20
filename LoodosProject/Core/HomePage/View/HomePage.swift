import SwiftUI

struct HomePage: View {
    @Namespace var namespace
    @StateObject private var homePageVM = HomePageViewModel()
    @StateObject private var notificationManager = NotificationManager()
    @State var selectedMovie: Movie?
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                searchBar()
                searchResults()
            }
            .onChange(of: homePageVM.searchText) {
               withAnimation(.spring) {
                   homePageVM.updateSearchButtonVisibility()
               }
           }
            if selectedMovie != nil {
                MovieDetailView(
                    namespace: namespace,
                    selectedMovie: $selectedMovie,
                    isSource: (selectedMovie != nil)
                )
            }
        }
       
        .hideKeyboard()
    }
    
    @ViewBuilder
    private func searchBar() -> some View {
        HStack {
            TextField("Search...", text: $homePageVM.searchText)
                .searchBarStyle(text: $homePageVM.searchText)
            
            if homePageVM.isSearchButtonVisible {
                CustomButton(
                    image: Image(systemName: "magnifyingglass"),
                    imageColor: .white,
                    buttonColor: Color(uiColor: Const.primaryColor),
                    padding: 8,
                    cornerRadius: 8,
                    action: performSearch
                )
                .padding(.trailing, 10)
            }
        }
    }
    
    @ViewBuilder
    private func searchResults() -> some View {
        Spacer()
        if homePageVM.startedSearch == nil {
            Text("Hiçbir Film Araması Yapmadınız")
                .font(.title3)
                .fontWeight(.semibold)
            
        } else if homePageVM.startedSearch! {
            AnimatedText(
                text: "Loading..",
                color: Const.primaryColor,
                animationEffect: 4,
                timeInterval: 0.3,
                textSize: 20,
                textJumpingSize: 5
            )
        } else {
            if let movieList = homePageVM.movieList, movieList.response == true {
                ScrollView {
                    LazyVStack {
                        ForEach(movieList.search!, id: \.imdbID) { movie in
                            MovieCard(
                                namespace: namespace,
                                movie: movie,
                                selectedMovie: $selectedMovie,
                                isSource: (selectedMovie == nil)
                            )
                            .padding(.vertical, 10)
                        }
                    }
                }.scrollIndicators(.hidden)
                    .padding(.top,8)
                
            }
            else {
                Text(homePageVM.error ?? "Bilinmeyen Hata")
            }
            
        }
        Spacer()
        
    }
    
    
    
    private func performSearch() {
        homePageVM.startedSearch = true
        homePageVM.searchMovie(query: homePageVM.searchText)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            homePageVM.startedSearch = false
            
        }
        
    }
}

#Preview {
    HomePage()
}
