//
//  TransactionHistoryCoordinator.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import UIKit

class TransactionHistoryCoordinator {
    static let shared = TransactionHistoryCoordinator()
    weak var delegate: TransactionsHistoryWireframe?
    private init() {}
    internal var isInternal = true
    
    func createTransactionsHistoryModule(_ transactionData: Spending) -> UIViewController {
        let viewModel = TransactionsHistoryViewModel(spendingData: transactionData)
        let viewController = TransactionsHistoryViewController(viewModel: viewModel)
        return viewController
    }
}
//fileprivate -> gaperlu oleh kelasnya snediri, yang penting satu file
//private -> hanya untuk kelas itu sendiri, dan bisa diakses dalam satu file
//public -> dia open untuk semua even ketika beda library/pod/module
//internal -> dia yang penting bisa diakses oleh classnya sendiri walaupun beda file
//interalLibrary

