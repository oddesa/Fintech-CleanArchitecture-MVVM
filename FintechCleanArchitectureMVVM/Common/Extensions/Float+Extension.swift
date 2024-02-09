//
//  NSNumber+Extension.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//
import Foundation


extension Float {
    func currencyString(localeIdentifier: String = "id_ID") -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: localeIdentifier)

        if let currencyString = formatter.string(from: NSNumber(value: self)) {
            return currencyString.replacingOccurrences(of: "p", with: "p. ")
        } else {
            return "Rp. 0"
        }
    }
}


