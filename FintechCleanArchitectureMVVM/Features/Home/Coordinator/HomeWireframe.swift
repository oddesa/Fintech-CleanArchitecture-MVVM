//
//  HomeWireframe.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import UIKit

protocol HomeWireframe: AnyObject {
    func navigateToTransactionHistory(_ transactionData: Spending)
}
