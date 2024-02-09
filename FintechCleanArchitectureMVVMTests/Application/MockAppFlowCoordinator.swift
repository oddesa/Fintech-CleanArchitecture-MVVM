//
//  MockAppFlowCoordinator.swift
//  FintechCleanArchitectureMVVMTests
//
//  Created by Jehnsen Hirena Kane on 04/12/23.
//

import Foundation
@testable import FintechCleanArchitectureMVVM

final class MockAppFlowCoordinator: HomeWireframe {
    var isNavigatingToTransactionHistory = false
    var isNavigatingBackFromTransactionHistory = false
    
    init() {
        HomeCoordinator.shared.delegate = self
        TransactionHistoryCoordinator.shared.delegate = self
    }
    
    func navigateToTransactionHistory(_ transactionData: FintechCleanArchitectureMVVM.Spending) {
        isNavigatingToTransactionHistory = true
    }
}

extension MockAppFlowCoordinator: TransactionsHistoryWireframe {
    func navigateBackFromTransactionHistory() {
        isNavigatingBackFromTransactionHistory = true
    }
}
