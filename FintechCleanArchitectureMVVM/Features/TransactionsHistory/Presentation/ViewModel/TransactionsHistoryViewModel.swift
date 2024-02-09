//
//  TransactionsHistoryViewModel.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation
import Combine
import UIKit

final class TransactionsHistoryViewModel {
    @Published var spendingData: Spending?
    private var cancellables: Set<AnyCancellable> = []
    init(spendingData: Spending) {
        self.spendingData = spendingData
    }
}
