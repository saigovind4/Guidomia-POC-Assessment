//
//  FilterViewModel.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import Foundation
class FilterViewModel
{
    var carSections = [DataSection]()
    
    var modelCarData : [String] {
        let data = carSections.compactMap({ $0.carDetail?.model })
        return !data.isEmpty ? data : []
    }
    
    var makeCarData : [String] {
        let data = carSections.compactMap({ $0.carDetail?.make })
        return !data.isEmpty ? data : []
    }
    
    init(_ carSections: [DataSection]) {
        self.carSections = carSections
    }
    
    func filterByModel(model: String) -> [DataSection] {
        let carData = carSections.filter { $0.carDetail?.model == model }
        return carData
    }
    
    func filterByMake(model: String) -> [DataSection] {
        let carData = carSections.filter { $0.carDetail?.make == model }
        return carData
    }
}

enum FilterType {
    case make
    case model
}
