//
//  NetworkingController.swift
//  Forecast_MVVM
//
//  Created by Chase on 3/8/23.
//

import Foundation

protocol NetworkingControllerServiceable {
    func fetchDays(with endpoint: DayEndpoint, completion: @escaping (Result <TopLevelDictionary, NetworkError>) -> Void)
}

struct NetworkingContoller: NetworkingControllerServiceable {
    
    // MARK: - Properties
    let apiProvider = APIDataProvider()
        
    // MARK: - Functions
    func fetchDays(with endpoint: DayEndpoint, completion: @escaping (Result <TopLevelDictionary, NetworkError>) -> Void) {
        guard let finalURL = endpoint.fullURL else { return }
        
        let request = URLRequest(url: finalURL)
        apiProvider.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    completion(.success(topLevelDictionary))
                } catch {
                    print("Error in Do/Try/Catch: \(error.localizedDescription)")
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}
