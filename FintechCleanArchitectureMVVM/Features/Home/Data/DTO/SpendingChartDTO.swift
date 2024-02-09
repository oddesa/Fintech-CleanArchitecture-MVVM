//
//  SpendingChartDataDTO.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//
import Foundation

struct SpendingHistoryDTO: Decodable {
    let transactionDate: String
    let nominal: Float
    
    enum Keys: String, CodingKey {
        case transactionDate = "trx_date"
        case nominal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        transactionDate = try container.decodeIfPresent(String.self, forKey: .transactionDate) ?? .emptyString
        nominal = try container.decodeIfPresent(Float.self, forKey: .nominal) ?? .zero
    }
    
    func toDomain() -> SpendingHistory {
        .init(transactionDate: transactionDate, nominal: nominal)
    }
}

struct SpendingDTO: Decodable {
    let label: String
    let percentage: Float
    let data: [SpendingHistoryDTO]
    
    enum Keys: String, CodingKey {
        case label, percentage, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        label = try container.decodeIfPresent(String.self, forKey: .label) ?? .emptyString
        let stringPercentage = try container.decodeIfPresent(String.self, forKey: .percentage) ?? .zeroString
        percentage = Float(stringPercentage) ?? .zero
        data = try container.decodeIfPresent([SpendingHistoryDTO].self, forKey: .data) ?? .init()
    }
    
    func toDomain() -> Spending {
        let data = data.map { item in
            item.toDomain()
        }
        return .init(label: label, percentage: percentage, data: data)
    }
}

struct SpendingChartDTO: Decodable {
    let type: String
    let data: [SpendingDTO]
    
    enum Keys: String, CodingKey {
        case type, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? .emptyString
        data = try container.decodeIfPresent([SpendingDTO].self, forKey: .data) ?? .init()
    }
    
    func toDomain() -> SpendingChartData {
        let data = data.map { item in
            item.toDomain()
        }
        return .init(type: type, data: data)
    }
}
