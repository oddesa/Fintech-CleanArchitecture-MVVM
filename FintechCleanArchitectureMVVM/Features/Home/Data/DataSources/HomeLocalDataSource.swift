//
//  HomeLocalDataSource.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation

protocol HomeLocalDataSource {
    func getLocalSpendingChartData(completion: @escaping (Result<SpendingChartDTO, Error>) -> Void)
    func getLocalProgressChartData(completion: @escaping (Result<ProgressChartDTO, Error>) -> Void)
}

extension HomeLocalDataSource {
    func getLocalSpendingChartData(completion: @escaping (Result<SpendingChartDTO, Error>) -> Void) {
        print("A")
    }
}
