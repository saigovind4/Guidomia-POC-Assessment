//
//  CarDetail.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import Foundation
class DataSection
{
    var carDetail : CarDetail?
    var isOpened = false
    
    init(carDetail: CarDetail?, isOpened: Bool = false) {
        self.carDetail = carDetail
        self.isOpened = isOpened
    }
}

struct CarDetail : Decodable {
    var consList : [String]
    var customerPrice: Int
    var make: String
    var marketPrice: Int
    var model: String
    var prosList: [String]
    var rating: Int

    var carPrice: String {
        return "Price :  "+customerPrice.roundedWithAbbreviations
    }
    
}
