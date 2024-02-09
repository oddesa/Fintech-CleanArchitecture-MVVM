//
//  ProgressChartDTO.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation

struct ProgressChartDTO: Decodable {
    let type: String
    let data: ProgressDTO
    
    enum Keys: String, CodingKey {
        case type, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? .emptyString
        data = try container.decodeIfPresent(ProgressDTO.self, forKey: .data) ?? .init()
    }
    
    func toDomain() -> ProgressChartData {
        return .init(type: type, data: data.toDomain())
    }
}

struct ProgressDTO: Decodable {
    let month: [Int]
    
    enum Keys: String, CodingKey {
        case month
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        month = try container.decodeIfPresent([Int].self, forKey: .month) ?? .init()
    }
    
    init() {
        month = []
    }
    
    func toDomain() -> Progress {
        .init(month: month)
    }
}

