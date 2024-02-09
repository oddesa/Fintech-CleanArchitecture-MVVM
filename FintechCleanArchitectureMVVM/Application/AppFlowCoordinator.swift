//
//  AppFlowCoordinator.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init( navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        setupWireframe()
    }
    
    private func setupWireframe() {
        HomeCoordinator.shared.delegate = self
        TransactionHistoryCoordinator.shared.delegate = self
    }

    func start() {
        navigationController.pushViewController(HomeCoordinator.shared.createHomeModule(), animated: true) 
    }
}

extension AppFlowCoordinator: HomeWireframe {
    func navigateToTransactionHistory(_ transactionData: Spending) {
        let viewController = TransactionHistoryCoordinator.shared.createTransactionsHistoryModule(transactionData)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension AppFlowCoordinator: TransactionsHistoryWireframe {
    func navigateBackFromTransactionHistory() {
        navigationController.popViewController(animated: true)
    }
}
