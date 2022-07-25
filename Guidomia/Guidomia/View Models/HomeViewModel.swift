//
//  HomeViewModel.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import Foundation
class HomeListViewModel 
{
    
    var sections : [DataSection] = [
        DataSection(carDetail: nil, isOpened: false)]
    
    var filterSections : [DataSection] = []
    private var carSections = [DataSection]()
    
    var isFilterSelected = false
    
    var numberOfSections: Int {
        if isFilterSelected {
            return filterSections.count
        } else {
            return sections.count
        }
    }
    
    func getCarListData()
    {
        JSONservice().fetchCarDetails { result in
            switch result
            {
            case .success(let cardetails) :
                for data in cardetails
                {
                    self.carSections.append(DataSection(carDetail: data,isOpened: false))
                }
                self.sections.append(contentsOf: self.carSections)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func sectionAtIndex(_ index: Int) -> DataSection {
        if isFilterSelected {
            let section = self.filterSections[index]
            return section
        } else {
            let section = self.sections[index]
            return section
        }
    }
}
