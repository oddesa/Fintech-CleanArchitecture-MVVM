//
//  GetSpendingChartDataUseCase.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation
import Combine
final class GetSpendingChartDataUseCase {

    private let homeRepository: HomeRepository

    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }

    func execute(completion: @escaping (Result<SpendingChartData, Error>) -> Void) -> Cancellable? {
        return homeRepository.getSpendingChartData { result in
            completion(result)
        }
    }
}
