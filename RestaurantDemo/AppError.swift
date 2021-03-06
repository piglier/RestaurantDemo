//
//  Error.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/17.
//

import Foundation

class AppError{
    enum ServerError: Error, LocalizedError {
        case GetCategoriesError
        case GetMenuError
        case FetchImageDataMissingError
        case PostOrderError
    }
    
    enum DecodeError: Error, LocalizedError {
        case decodeCategoriesError
    }
}

