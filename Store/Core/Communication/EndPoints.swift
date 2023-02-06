//
//  EndPoints.swift
//  Store
//
//  Created by Bola Fayez on 01/01/2023.
//

import Foundation

enum EndPoints {
    
    case fetchProducts

    private var baseURLString: String { Strings.BASE_URL }

    private var url: URL? {
        switch self {
        case .fetchProducts:
            return URL(string: "\(baseURLString)/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json")
        }
    }

    private var parameters: [URLQueryItem] {
        switch self {
        case .fetchProducts : return []
        }
    }

    func asRequest() -> String {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }

        return url.description
    }
    
}
