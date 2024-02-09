//
//  MockHomeRepository.swift
//  FintechCleanArchitectureMVVMTests
//
//  Created by Jehnsen Hirena Kane on 04/12/23.
//

import Foundation
import Combine

@testable import FintechCleanArchitectureMVVM

final class MockHomeRepository: HomeRepository {
    private var localDataSource = DefaultHomeLocalDataSource()
    var isReturningCorrectData = false
    func getSpendingChartData(completion: @escaping (Result<FintechCleanArchitectureMVVM.SpendingChartData, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        if isReturningCorrectData {
            localDataSource.getLocalSpendingChartData { result in
                switch result {
                case .success(let data):
                    completion(.success(data.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(MockError.intentionalError))
        }
        return task
    }
    
    func getProgressChartData(completion: @escaping (Result<FintechCleanArchitectureMVVM.ProgressChartData, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        if isReturningCorrectData {
            localDataSource.getLocalProgressChartData { result in
                switch result {
                case .success(let data):
                    completion(.success(data.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(MockError.intentionalError))
        }
        return task
    }
    
    
}
