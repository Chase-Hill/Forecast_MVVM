//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Chase on 3/8/23.
//

import Foundation

protocol DayDetailViewModelDelegate: DayDetailsViewController {
    func updateViews()
}

class DayDetailViewModel {

    // MARK: - Properties
    var forecastData: TopLevelDictionary?
    var days: [Day] { forecastData?.days ?? [] }
    private weak var delegate: DayDetailViewModelDelegate?
    let dayService: NetworkingControllerServiceable
    
    init(delegate: DayDetailViewModelDelegate, serviceInjected: NetworkingControllerServiceable = NetworkingContoller()) {
        self.delegate = delegate
        self.dayService = serviceInjected
        self.fetchData()
    }

    // MARK: - Functions
    func fetchData() {
        dayService.fetchDays(with: .postalCode("30107")) { result in
            switch result {
            case .success(let topLevelDictionary):

                self.forecastData = topLevelDictionary
                self.delegate?.updateViews()
            case .failure(let error):

                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
}
