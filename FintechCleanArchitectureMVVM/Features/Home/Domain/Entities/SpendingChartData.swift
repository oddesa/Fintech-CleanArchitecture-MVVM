//
//  Transaction.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation

struct SpendingHistory: Hashable {
    let transactionDate: String
    let nominal: Float
}

struct Spending {
    let label: String
    let percentage: Float
    let data: [SpendingHistory]
}

struct SpendingChartData {
    let type: String
    let data: [Spending]
}
