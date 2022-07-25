//
//  FilterViewController.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import UIKit
protocol FilterManagerDelegate : AnyObject {
    func updateFilterData(selectedItem: String, updatedData: [DataSection], filterType: FilterType)
    func filterCleared()
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var filterVm : FilterViewModel?
    var filterDataArray = [String]()
    weak var delegate: FilterManagerDelegate?
    var filterType = FilterType.make
    private var selectedIndex = -1
    var selectedBtnTitle = String()
    public static var viewControllerIdentifier : String
    {
        return String(describing: FilterViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        if let index = filterDataArray.firstIndex(of: selectedBtnTitle)
        {
            selectedIndex = index
        }
    }
    
    @IBAction func closeButtonTapped(sender : UIButton) {
        if let delegate = delegate {
            delegate.filterCleared()
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if selectedIndex != -1
        {
            if let cell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))
            {
                cell.accessoryType = .checkmark
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = filterDataArray[indexPath.row]
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            var uniqueData = [DataSection]()
            switch filterType {
            case .make:
                uniqueData = filterVm!.filterByMake(model: filterDataArray[indexPath.row])
                delegate.updateFilterData(selectedItem: filterDataArray[indexPath.row], updatedData: uniqueData, filterType: .make)
            case .model:
                uniqueData = filterVm!.filterByModel(model: filterDataArray[indexPath.row])
                delegate.updateFilterData(selectedItem: filterDataArray[indexPath.row], updatedData: uniqueData, filterType: .model)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}
