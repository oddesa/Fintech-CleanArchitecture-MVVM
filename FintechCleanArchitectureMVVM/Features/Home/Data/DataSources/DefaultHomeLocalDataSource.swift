//
//  DefaultHomeLocalDataSource.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import Foundation

final class DefaultHomeLocalDataSource: HomeLocalDataSource {
//    func getLocalSpendingChartData(completion: @escaping (Result<SpendingChartDTO, Error>) -> Void) {
//        let spendingChartDTOResponse =
//            """
//            {
//                "type": "donutChart",
//                "data": [
//                    {
//                        "label": "Tarik Tunai",
//                        "percentage": "55",
//                        "data": [
//                            {
//                                "trx_date": "21/01/2023",
//                                "nominal": 1000000
//                            },
//                            {
//                                "trx_date": "20/01/2023",
//                                "nominal": 500000
//                            },
//                            {
//                                "trx_date": "19/01/2023",
//                                "nominal": 1000000
//                            }
//                        ]
//                    },
//                    {
//                        "label": "QRIS Payment",
//                        "percentage": "31",
//                        "data": [
//                            {
//                                "trx_date": "21/01/2023",
//                                "nominal": 159000
//                            },
//                            {
//                                "trx_date": "20/01/2023",
//                                "nominal": 35000
//                            },
//                            {
//                                "trx_date": "19/01/2023",
//                                "nominal": 1500
//                            }
//                        ]
//                    },
//                    {
//                        "label": "Topup Gopay",
//                        "percentage": "7.7",
//                        "data": [
//                            {
//                                "trx_date": "21/01/2023",
//                                "nominal": 200000
//                            },
//                            {
//                                "trx_date": "20/01/2023",
//                                "nominal": 195000
//                            },
//                            {
//                                "trx_date": "19/01/2023",
//                                "nominal": 5000000
//                            }
//                        ]
//                    },
//                    {
//                        "label": "Lainnya",
//                        "percentage": "6.3",
//                        "data": [
//                            {
//                                "trx_date": "21/01/2023",
//                                "nominal": 1000000
//                            },
//                            {
//                                "trx_date": "20/01/2023",
//                                "nominal": 500000
//                            },
//                            {
//                                "trx_date": "19/01/2023",
//                                "nominal": 1000000
//                            }
//                        ]
//                    }
//                ]
//            }
//            """
//        let spendingChartDTOData = spendingChartDTOResponse.data(using: .utf8)!
//        do {
//            let decodedData = try JSONDecoder().decode(SpendingChartDTO.self, from: spendingChartDTOData)
//            completion(.success(decodedData))
//        } catch {
//            completion(.failure(error))
//        }
//    }
    
    func getLocalProgressChartData(completion: @escaping (Result<ProgressChartDTO, Error>) -> Void) {
        let progressChartDTOResponse =
            """
                {
                    "type": "lineChart",
                    "data": {
                        "month": [
                            3,
                            7,
                            8,
                            10,
                            5,
                            10,
                            1,
                            3,
                            5,
                            10,
                            7,
                            7
                        ]
                    }
                }
            """
        let progressChartDTOData = progressChartDTOResponse.data(using: .utf8)!
        do {
            let decodedData = try JSONDecoder().decode(ProgressChartDTO.self, from: progressChartDTOData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}
