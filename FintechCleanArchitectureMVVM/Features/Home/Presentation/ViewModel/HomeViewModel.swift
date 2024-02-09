//
//  HomeViewModel.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation
import Combine

final class HomeViewModel {
    @Published var spendingChartData: SpendingChartData?
    @Published var progressChartData: ProgressChartData?
    @Published var error: String?
    private var fetchSpendingChartDataTask: Cancellable?
    private var fetchProcessChartDataTask: Cancellable?
    private let getSpendingChartDataUseCase: GetSpendingChartDataUseCase
    private let getProgressChartDataUseCase: GetProgressChartDataUseCase
    
    init(getSpendingChartDataUseCase: GetSpendingChartDataUseCase, getProgressChartDataUseCase: GetProgressChartDataUseCase) {
        self.getSpendingChartDataUseCase = getSpendingChartDataUseCase
        self.getProgressChartDataUseCase = getProgressChartDataUseCase
    }
    
    func fetchChartData() {
        fetchSpendingChartData()
        fetchProcessChartData()
    }
    
    private func fetchSpendingChartData() {
        fetchSpendingChartDataTask = getSpendingChartDataUseCase.execute { [weak self] result in
            switch result {
            case .success(let data):
                self?.spendingChartData = data
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    private func fetchProcessChartData() {
        fetchProcessChartDataTask = getProgressChartDataUseCase.execute{ [weak self] result in
            switch result {
            case .success(let data):
                self?.progressChartData = data
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    func navigateToTransactionDetail(_ spendingName: String) {
        guard let data = spendingChartData?.data.first(where: { spending in
            spending.label == spendingName
        }) else {
            return
        }
        HomeCoordinator.shared.delegate?.navigateToTransactionHistory(data)
    }
}
