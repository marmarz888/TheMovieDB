//
//  MoviesAndShows.swift
//  TheMovieDB
//
//  Created by Mariano Manuel on 7/16/22.
//

import SwiftUI

struct MoviesAndShows: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var movieOrShow = "Popular"
    
    @State var PopularMovieInfo: [Any] = []
    @State var PopularPosterData: [Data] = []
    @State var PopularTitles: [String] = []
    @State var PopularOverviews: [String] = []
    @State var PopularDates: [String] = []
    @State var PopularRatings: [Double] = []
    
    @State var TopRatedMovieInfo: [Any] = []
    @State var TopRatedPosterData: [Data] = []
    @State var TopRatedTitles: [String] = []
    @State var TopRatedOverviews: [String] = []
    @State var TopRatedDates: [String] = []
    @State var TopRatedRatings: [Double] = []
    
    @State var OnTVInfo: [Any] = []
    @State var OnTVPosterData: [Data] = []
    @State var OnTVTitles: [String] = []
    @State var OnTVOverviews: [String] = []
    @State var OnTVDates: [String] = []
    @State var OnTVRatings: [Double] = []
    
    @State var AiringTodayInfo: [Any] = []
    @State var AiringTodayPosterData: [Data] = []
    @State var AiringTodayTitles: [String] = []
    @State var AiringTodayOverviews: [String] = []
    @State var AiringTodayDates: [String] = []
    @State var AiringTodayRatings: [Double] = []
    
    @State var Loaded1: Bool = false
    @State var Loaded2: Bool = false
    @State var Loaded3: Bool = false
    @State var Loaded4: Bool = false
    
    var content = ["Popular", "Top Rated", "On TV", "Airing Today"]
    private var gridLayout = [GridItem(.fixed(150)), GridItem(.fixed(150))]
    var contentService = ContentService()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Movie Or Show Type", selection: $movieOrShow) {
                    ForEach(content, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: gridLayout) {
                            ForEach((0..<20)) { (i) in
                                if PopularPosterData.count == 20 {
                                    if Loaded1 && Loaded2 && Loaded3 && Loaded4 {
                                        if movieOrShow == "Popular" {
                                            NavigationLink(
                                                destination: {
                                                    Details(Poster: $PopularPosterData[i], Title: $PopularTitles[i], ReleaseDate: $PopularDates[i], Overview: $PopularOverviews[i], Rating: $PopularRatings[i])
                                                        .environment(\.managedObjectContext, viewContext)
                                                },
                                                label: {
                                                    Image(uiImage: UIImage(data: PopularPosterData[i])!)
                                                        .resizable()
                                                        .scaledToFit()
                                                })
                                        } else if movieOrShow == "Top Rated" {
                                            NavigationLink(
                                                destination: {
                                                    Text("DEMO")
                                                    //Details(Poster: $TopRatedPosterData[i], Title: $TopRatedTitles[i], ReleaseDate: $TopRatedDates[i], Overview: $TopRatedOverviews[i], Rating: $TopRatedRatings[i])
                                                        //.environment(\.managedObjectContext, viewContext)
                                                },
                                                label: {
                                                    Image(uiImage: UIImage(data: TopRatedPosterData[i])!)
                                                        .resizable()
                                                        .scaledToFit()
                                                })
                                        } else if movieOrShow == "On TV" {
                                            NavigationLink(
                                                destination: {
                                                    Text("DEMO")
                                                    //Details(Poster: $OnTVPosterData[i], Title: $OnTVTitles[i], ReleaseDate: $OnTVDates[i], Overview: $OnTVOverviews[i], Rating: $OnTVRatings[i])
                                                        //.environment(\.managedObjectContext, viewContext)
                                                },
                                                label: {
                                                    Image(uiImage: UIImage(data: OnTVPosterData[i])!)
                                                        .resizable()
                                                        .scaledToFit()
                                                })
                                        } else if movieOrShow == "Airing Today" {
                                            NavigationLink(
                                                destination: {
                                                    Text("DEMO")
                                                    //Details(Poster: $AiringTodayPosterData[i], Title: $AiringTodayTitles[i], ReleaseDate: $AiringTodayDates[i], Overview: $AiringTodayOverviews[i], Rating: $AiringTodayRatings[i])
                                                        //.environment(\.managedObjectContext, viewContext)
                                                },
                                                label: {
                                                    Image(uiImage: UIImage(data: AiringTodayPosterData[i])!)
                                                        .resizable()
                                                        .scaledToFit()
                                                })
                                        }
                                    } else {
                                        NavigationLink(
                                            destination: EmptyView(),
                                            label: {
                                                Image(systemName: "questionmark.app")
                                                    .resizable()
                                                    .scaledToFit()
                                            })
                                    }
                                } else {
                                    NavigationLink(
                                        destination: EmptyView(),
                                        label: {
                                            Image(systemName: "questionmark.app")
                                                .resizable()
                                                .scaledToFit()
                                        })
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Movies And Shows")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Favorites().environment(\.managedObjectContext, viewContext)) {
                        Image(systemName: "star.fill")
                    }
                }
            }
            .overlay(content: {
                if !Loaded1 || !Loaded2 || !Loaded3 || !Loaded4 {
                    ProgressView()
                        .scaleEffect(3)
                }
            })
            .onAppear {
                contentService.LoadMovieDatabaseAPI(taskNumber: 1) { (Info1) in
                    if let Info1 = Info1 {
                        PopularMovieInfo = Info1
                        DispatchQueue.global().async {
                            var images: [Data] = []
                            var titles: [String] = []
                            var dates: [String] = []
                            var overviews: [String] = []
                            var ratings: [Double] = []
                            for i in 0..<PopularMovieInfo.count {
                                let movie = PopularMovieInfo[i] as! [String: Any]
                                let poster_path = movie["poster_path"] as! String
                                let movieTitle = movie["title"] as! String
                                let movieReleaseDate = movie["release_date"]
                                let movieOverview = movie["overview"]
                                let movieRating = movie["vote_average"] as! Double
                                let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                let imageURL = URL(string: strURL)!
                                do {
                                    let data = try Data(contentsOf: imageURL)
                                    images.append(data)
                                    titles.append(movieTitle)
                                    dates.append(movieReleaseDate as! String)
                                    overviews.append(movieOverview as! String)
                                    ratings.append(movieRating)
                                } catch  {
                                    print(error)
                                }
                            }
                            DispatchQueue.main.sync {
                                print("Loaded1")
                                
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
                                    PopularPosterData = images
                                    PopularTitles = titles
                                    PopularDates = dates
                                    PopularOverviews = overviews
                                    PopularRatings = ratings
                                    Loaded1 = true
                                }
                            }
                        }
                    }
                }
                
                contentService.LoadMovieDatabaseAPI(taskNumber: 2) { (Info2) in
                    if let Info2 = Info2 {
                        TopRatedMovieInfo = Info2
                        DispatchQueue.global().async {
                            var images: [Data] = []
                            var titles: [String] = []
                            var dates: [String] = []
                            var overviews: [String] = []
                            var ratings: [Double] = []
                            for j in 0..<TopRatedMovieInfo.count {
                                let movie = TopRatedMovieInfo[j] as! [String: Any]
                                let poster_path = movie["poster_path"] as! String
                                let movieTitle = movie["title"] as! String
                                let movieReleaseDate = movie["release_date"]
                                let movieOverview = movie["overview"]
                                let movieRating = movie["vote_average"] as! Double
                                let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                let imageURL = URL(string: strURL)!
                                do {
                                    let data = try Data(contentsOf: imageURL)
                                    images.append(data)
                                    titles.append(movieTitle)
                                    dates.append(movieReleaseDate as! String)
                                    overviews.append(movieOverview as! String)
                                    ratings.append(movieRating)
                                } catch  {
                                    print(error)
                                }
                            }
                            DispatchQueue.main.sync {
                                print("Loaded2")
                                
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
                                    TopRatedPosterData = images
                                    TopRatedTitles = titles
                                    TopRatedDates = dates
                                    TopRatedOverviews = overviews
                                    TopRatedRatings = ratings
                                    Loaded2 = true
                                }
                            }
                        }
                    }
                }
                
                contentService.LoadMovieDatabaseAPI(taskNumber: 3) { (Info3) in
                    if let Info3 = Info3 {
                        OnTVInfo = Info3
                        DispatchQueue.global().async {
                            var images: [Data] = []
                            var titles: [String] = []
                            var dates: [String] = []
                            var overviews: [String] = []
                            var ratings: [Double] = []
                            for k in 0..<OnTVInfo.count {
                                let tvShow = OnTVInfo[k] as! [String: Any]
                                let poster_path = tvShow["poster_path"] as! String
                                let tvTitle = tvShow["name"] as! String
                                let tvReleaseDate = tvShow["first_air_date"]
                                let tvOverview = tvShow["overview"]
                                let tvRating = tvShow["vote_average"] as! Double
                                let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                let imageURL = URL(string: strURL)!
                                do {
                                    let data = try Data(contentsOf: imageURL)
                                    images.append(data)
                                    titles.append(tvTitle)
                                    dates.append(tvReleaseDate as! String)
                                    overviews.append(tvOverview as! String)
                                    ratings.append(tvRating)
                                } catch  {
                                    print(error)
                                }
                            }
                            DispatchQueue.main.sync {
                                print("Loaded3")
                                
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
                                    OnTVPosterData = images
                                    OnTVTitles = titles
                                    OnTVDates = dates
                                    OnTVOverviews = overviews
                                    OnTVRatings = ratings
                                    Loaded3 = true
                                }
                            }
                        }
                    }
                }
                
                contentService.LoadMovieDatabaseAPI(taskNumber: 4) { (Info4) in
                    if let Info4 = Info4 {
                        AiringTodayInfo = Info4
                        DispatchQueue.global().async {
                            var images: [Data] = []
                            var titles: [String] = []
                            var dates: [String] = []
                            var overviews: [String] = []
                            var ratings: [Double] = []
                            for l in 0..<AiringTodayInfo.count {
                                let tvShow = AiringTodayInfo[l] as! [String: Any]
                                let poster_path = tvShow["poster_path"] as! String
                                let tvTitle = tvShow["name"] as! String
                                let tvReleaseDate = tvShow["first_air_date"]
                                let tvOverview = tvShow["overview"]
                                let tvRating = tvShow["vote_average"] as! Double
                                let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                let imageURL = URL(string: strURL)!
                                do {
                                    let data = try Data(contentsOf: imageURL)
                                    images.append(data)
                                    titles.append(tvTitle)
                                    dates.append(tvReleaseDate as! String)
                                    overviews.append(tvOverview as! String)
                                    ratings.append(tvRating)
                                } catch  {
                                    print(error)
                                }
                            }
                            DispatchQueue.main.sync {
                                print("Loaded4")
                                
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
                                    AiringTodayPosterData = images
                                    AiringTodayTitles = titles
                                    AiringTodayDates = dates
                                    AiringTodayOverviews = overviews
                                    AiringTodayRatings = ratings
                                    Loaded4 = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MoviesAndShows_Previews: PreviewProvider {
    static var previews: some View {
        MoviesAndShows().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
