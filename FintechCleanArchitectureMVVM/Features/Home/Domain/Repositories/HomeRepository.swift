//
//  HomeRepositories.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//
import Foundation
import Combine

protocol HomeRepository {
    func getSpendingChartData(completion: @escaping (Result<SpendingChartData, Error>) -> Void) -> Cancellable?
    func getProgressChartData(completion: @escaping (Result<ProgressChartData, Error>) -> Void) -> Cancellable?
}
