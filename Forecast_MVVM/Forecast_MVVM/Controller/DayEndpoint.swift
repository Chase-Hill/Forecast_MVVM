//
//  DayEndpoint.swift
//  Forecast_MVVM
//
//  Created by Chase on 3/9/23.
//

import Foundation

enum DayEndpoint {
    static let baseURL = URL(string: "https://api.weatherbit.io")
    static let apiQuery = URLQueryItem(name: "key", value: "8503276d5f49474f953722fa0a8e7ef8")
    static let dailyPath = "/v2.0/forecast/daily"
    static let unitsQuery = URLQueryItem(name: "units", value: "I")
    
    case city(String)
    case postalCode(String)
    
    var fullURL: URL? {
        guard let url = Self.baseURL,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        switch self {
        case .city(let cityName):
            urlComponents.path.append(Self.dailyPath)
            let cityQuery = URLQueryItem(name: "city", value: cityName)
            let unitsQuery = Self.unitsQuery
            urlComponents.queryItems = [Self.apiQuery, cityQuery, unitsQuery]
            
        case .postalCode(let postalCode):
            urlComponents.path.append(Self.dailyPath)
            let postalQuery = URLQueryItem(name: "postal_code", value: postalCode)
            let unitsQuery = Self.unitsQuery
            urlComponents.queryItems = [Self.apiQuery, postalQuery, unitsQuery]
        }
        return urlComponents.url
    }
}
