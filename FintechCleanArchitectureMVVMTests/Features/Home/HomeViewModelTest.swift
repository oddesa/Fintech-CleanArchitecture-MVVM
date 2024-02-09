//
//  HomeViewModelTest.swift
//  FintechCleanArchitectureMVVMTests
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation
import Quick
import Nimble
@testable import FintechCleanArchitectureMVVM

class HomeViewModelTest: QuickSpec {
    override class func spec() {
        describe("Test HomeViewModel") {
            var mockAppFlowCoordinator: MockAppFlowCoordinator!
            var mockHomeRepository: MockHomeRepository!
            var getSpendingChartDataUseCase: GetSpendingChartDataUseCase!
            var getProgressChartDataUseCase: GetProgressChartDataUseCase!
            var viewModel: HomeViewModel!
            beforeEach {
                mockAppFlowCoordinator = MockAppFlowCoordinator()
                mockHomeRepository = MockHomeRepository()
                getSpendingChartDataUseCase = GetSpendingChartDataUseCase(homeRepository: mockHomeRepository)
                getProgressChartDataUseCase = GetProgressChartDataUseCase(homeRepository: mockHomeRepository)
                viewModel = HomeViewModel(getSpendingChartDataUseCase: getSpendingChartDataUseCase,
                                          getProgressChartDataUseCase: getProgressChartDataUseCase)
            }
            
            context("Success Fetch Data") {
                it("Success Fetch Donut Chart Data") {
                    mockHomeRepository.isReturningCorrectData = true
                    viewModel.fetchChartData()
                    expect(viewModel.spendingChartData).toNot(beNil())
                }
                
                it("Success Fetch Line Chart Data") {
                    mockHomeRepository.isReturningCorrectData = true
                    viewModel.fetchChartData()
                    expect(viewModel.progressChartData).toNot(beNil())
                }
            }
            
            context("Failed Fetch Data") {
                it("Failed Fetch Donut Chart Data") {
                    viewModel.fetchChartData()
                    expect(viewModel.spendingChartData).to(beNil())
                }
                
                it("Success Fetch Line Chart Data") {
                    viewModel.fetchChartData()
                    expect(viewModel.progressChartData).to(beNil())
                }
            }
            
            context("Correctly Navigating") {
                it("Success Navigating to Transaction History Page") {
                    mockHomeRepository.isReturningCorrectData = true
                    viewModel.fetchChartData()
                    viewModel.navigateToTransactionDetail("Lainnya")
                    expect(mockAppFlowCoordinator.isNavigatingToTransactionHistory).to(beTrue())
                }
                
                it("Failed Navigating to Transaction History Page") {
                    viewModel.fetchChartData()
                    viewModel.navigateToTransactionDetail("Lainnya")
                    expect(mockAppFlowCoordinator.isNavigatingToTransactionHistory).to(beFalse())
                }
            }
        }
    }
}
