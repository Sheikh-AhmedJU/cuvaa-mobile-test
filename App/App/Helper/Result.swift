//
//  Result.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
