//
//  GetProgressChartDataUseCase.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation
import Combine
final class GetProgressChartDataUseCase {

    private let homeRepository: HomeRepository

    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }

    func execute(completion: @escaping (Result<ProgressChartData, Error>) -> Void) -> Cancellable? {
        return homeRepository.getProgressChartData { result in
            completion(result)
        }
    }
}
