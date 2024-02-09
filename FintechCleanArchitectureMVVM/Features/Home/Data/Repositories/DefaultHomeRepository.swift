//
//  DefaultHomeRepositories.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation
import Combine

final class DefaultHomeRepository {
    
//    private let remoteDataSource: HomeRemoteDataSource
    private let localDataSource: HomeLocalDataSource

    init(localDataSource: HomeLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension DefaultHomeRepository: HomeRepository {
    func getSpendingChartData(completion: @escaping (Result<SpendingChartData, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        localDataSource.getLocalSpendingChartData { result in
            guard !task.isCancelled else {
                return
            }
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func getProgressChartData(completion: @escaping (Result<ProgressChartData, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        localDataSource.getLocalProgressChartData { result in
            guard !task.isCancelled else {
                return
            }
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
