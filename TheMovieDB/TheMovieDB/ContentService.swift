//
//  ContentService.swift
//  TheMovieDB
//
//  Created by Mariano Manuel on 7/16/22.
//

import Foundation

class ContentService {
    func LoadMovieDatabaseAPI(taskNumber: Int, completeData: @escaping ([Any]?) -> Void) {
        print("Loading Movies")
        //Example API Call - /3/movie/popular?api_key=5bbf70742ff5480a08fefe89bd22d7f3&language=en
        //Example 2 API Call - /3/tv/on_the_air?api_key=5bbf70742ff5480a08fefe89bd22d7f3&language=en
        let APIMovieLock_Key = "?api_key=5bbf70742ff5480a08fefe89bd22d7f3"
        let baseURL = "https://api.themoviedb.org/3/"
        var type = "?"
        type = "movie/popular"
        let languageSetting = "&language=en"
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        var dataTask2: URLSessionDataTask?
        var dataTask3: URLSessionDataTask?
        var dataTask4: URLSessionDataTask?
        
        if taskNumber == 1 {
            let movieServiceURL = baseURL+type+APIMovieLock_Key+languageSetting
            dataTask?.cancel() //Poes
            guard let urlLink = URL(string: movieServiceURL) else { return }
            print("Configured URL and DataSession")
            dataTask = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
                print("Started Data Task")
                if let error = error {
                    print("Error Found")
                    print(error.localizedDescription)
                } else if let data = data {
                    print("Retrieving Data")
                    var response: [String: Any]?
                    do {
                        if #available(iOS 15.0, *) {
                            response = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .json5Allowed, .fragmentsAllowed]) as? [String: Any]
                        } else {
                            // Fallback on earlier versions
                            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        }
                    } catch _ as NSError { return }
                    guard let information = response!["results"] as? [Any] else { return }
                    DispatchQueue.main.async {
                        print(information)
                        completeData(information)
                    }
                }
            })
            dataTask?.resume()
        } else if taskNumber == 2 {
            type = "movie/top_rated"
            let movieServiceURL = baseURL+type+APIMovieLock_Key+languageSetting
            dataTask2?.cancel() //Poes
            guard let urlLink = URL(string: movieServiceURL) else { return }
            print("Configured URL and DataSession")
            dataTask2 = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
                print("Started Data Task")
                if let error = error {
                    print("Error Found")
                    print(error.localizedDescription)
                } else if let data = data {
                    print("Retrieving Data")
                    var response: [String: Any]?
                    do {
                        if #available(iOS 15.0, *) {
                            response = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .json5Allowed, .fragmentsAllowed]) as? [String: Any]
                        } else {
                            // Fallback on earlier versions
                            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        }
                    } catch _ as NSError { return }
                    guard let information = response!["results"] as? [Any] else { return }
                    DispatchQueue.main.async {
                        print(information)
                        completeData(information)
                    }
                }
            })
            dataTask2?.resume()
        } else if taskNumber == 3 {
            type = "tv/on_the_air"
            let movieServiceURL = baseURL+type+APIMovieLock_Key+languageSetting
            dataTask3?.cancel() //Poes
            guard let urlLink = URL(string: movieServiceURL) else { return }
            print("Configured URL and DataSession")
            dataTask3 = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
                print("Started Data Task")
                if let error = error {
                    print("Error Found")
                    print(error.localizedDescription)
                } else if let data = data {
                    print("Retrieving Data")
                    var response: [String: Any]?
                    do {
                        if #available(iOS 15.0, *) {
                            response = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .json5Allowed, .fragmentsAllowed]) as? [String: Any]
                        } else {
                            // Fallback on earlier versions
                            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        }
                    } catch _ as NSError { return }
                    guard let information = response!["results"] as? [Any] else { return }
                    DispatchQueue.main.async {
                        print(information)
                        completeData(information)
                    }
                }
            })
            dataTask3?.resume()
        } else if taskNumber == 4 {
            type = "tv/airing_today"
            let movieServiceURL = baseURL+type+APIMovieLock_Key+languageSetting
            dataTask4?.cancel() //Poes
            guard let urlLink = URL(string: movieServiceURL) else { return }
            print("Configured URL and DataSession")
            dataTask4 = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
                print("Started Data Task")
                if let error = error {
                    print("Error Found")
                    print(error.localizedDescription)
                } else if let data = data {
                    print("Retrieving Data")
                    var response: [String: Any]?
                    do {
                        if #available(iOS 15.0, *) {
                            response = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .json5Allowed, .fragmentsAllowed]) as? [String: Any]
                        } else {
                            // Fallback on earlier versions
                            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        }
                    } catch _ as NSError { return }
                    guard let information = response!["results"] as? [Any] else { return }
                    DispatchQueue.main.async {
                        print(information)
                        completeData(information)
                    }
                }
            })
            dataTask4?.resume()
        }
    }
}
