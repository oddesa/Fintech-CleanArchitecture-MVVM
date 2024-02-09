//
//  RepositoryTask.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation
import Combine
class RepositoryTask: Cancellable {
    var isCancelled: Bool = false
    
    func cancel() {
        isCancelled = true
    }
}
