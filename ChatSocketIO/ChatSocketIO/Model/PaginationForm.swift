//
//  PaginationForm.swift
//  CAB
//
//  Created by Ahmed Fathy on 16/10/2023.
//

import Foundation
import Infrastructure

struct PaginationForm {
    var page: Int
    var itemPerPage: Int = 20
    
    var parameters: Parameters {
        ["page":page, "per_page":itemPerPage]
    }
}
