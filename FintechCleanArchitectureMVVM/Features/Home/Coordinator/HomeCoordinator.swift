//
//  HomeCoordinator.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import UIKit

class HomeCoordinator {
    static let shared = HomeCoordinator()
    weak var delegate: HomeWireframe?
    private init() {}
    
    func createHomeModule() -> UIViewController {
        let homeRepository = DefaultHomeRepository(localDataSource: DefaultHomeLocalDataSource())
        let getSpendingChartDataUseCase = GetSpendingChartDataUseCase(homeRepository: homeRepository)
        let getProgressChartDataUseCase = GetProgressChartDataUseCase(homeRepository: homeRepository)
        let viewModel = HomeViewModel(getSpendingChartDataUseCase: getSpendingChartDataUseCase,
                                      getProgressChartDataUseCase: getProgressChartDataUseCase)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}
