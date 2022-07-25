//
//  ViewController.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var homeListVM = HomeListViewModel()
    private let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    private var bannerView = BannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeListVM.getCarListData()
        bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 500))
        bannerView.anyMakeButton.addTarget(self, action:#selector(handleMakeButton(sender:)), for: .touchUpInside)
        bannerView.anyModelButton.addTarget(self, action:#selector(handleModelButton(sender:)), for: .touchUpInside)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName:  ItemCollapseCell.identifier, bundle: nil), forCellReuseIdentifier: ItemCollapseCell.identifier)
        tableView.register(UINib(nibName: CarDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CarDetailTableViewCell.identifier)
        tableView.remembersLastFocusedIndexPath = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if homeListVM.sections.count > 2
        {
            let indexPath = IndexPath(row: 0, section: 1)
            homeListVM.sections[indexPath.section].isOpened = !homeListVM.sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
            
        }
        
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 0 {
            let section = homeListVM.sectionAtIndex(section)
            if section.isOpened {
                return 2
            } else {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return bannerView
        } 
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let carDetail = homeListVM.sectionAtIndex(indexPath.section).carDetail else {  return UITableViewCell() }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemCollapseCell.identifier, for: indexPath) as! ItemCollapseCell
            cell.updateBottomView(status: homeListVM.sectionAtIndex(indexPath.section).isOpened)
            cell.setUpData(carData: carDetail)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailTableViewCell.identifier, for: indexPath) as! CarDetailTableViewCell
            cell.prosArray = carDetail.prosList
            cell.consArray = carDetail.consList
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        disablePreviousCell(selectedSection: indexPath.section)
        tableView.deselectRow(at: indexPath, animated: false)
        homeListVM.sectionAtIndex(indexPath.section).isOpened = !homeListVM.sectionAtIndex(indexPath.section).isOpened
        tableView.reloadSections([indexPath.section], with: .none)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 500
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func disablePreviousCell(selectedSection: Int)
    {
        if let section = homeListVM.sections.firstIndex(where: { value in
            value.isOpened == true
        }) {
            if selectedSection != section {
                homeListVM.sections[section].isOpened = !homeListVM.sections[section].isOpened
                tableView.reloadSections([section], with: .fade)
            }
        }
    }
    
}
extension ViewController : FilterManagerDelegate
{
    
    @objc func handleMakeButton(sender: UIButton){
        let filterVc = storyBoard.instantiateViewController(withIdentifier: FilterViewController.viewControllerIdentifier) as! FilterViewController
        filterVc.filterVm = FilterViewModel(homeListVM.sections)
        filterVc.filterType = .make
        filterVc.delegate = self
        if bannerView.anyMakeButton.currentTitle != "Any make" {
            filterVc.selectedBtnTitle = bannerView.anyMakeButton.currentTitle ?? ""
        }
        filterVc.filterDataArray = filterVc.filterVm!.makeCarData
        self.present(filterVc, animated: true)
    }
    
    @objc func handleModelButton(sender: UIButton){
        let filterVc = storyBoard.instantiateViewController(withIdentifier: FilterViewController.viewControllerIdentifier) as! FilterViewController
        filterVc.filterVm = FilterViewModel(homeListVM.sections)
        filterVc.filterType = .model
        filterVc.delegate = self
        filterVc.filterDataArray = filterVc.filterVm!.modelCarData
        if bannerView.anyModelButton.currentTitle != "Any model" {
            filterVc.selectedBtnTitle = bannerView.anyModelButton.currentTitle ?? ""
        }
        self.present(filterVc, animated: true)
    }
    
    func updateFilterData(selectedItem: String, updatedData: [DataSection], filterType: FilterType) {
        let updatedList : [DataSection] =  [ DataSection(carDetail: nil, isOpened: false) ]
        homeListVM.isFilterSelected = true
        homeListVM.filterSections.removeAll()
        switch filterType {
        case .make:
            bannerView.anyMakeButton.setTitle(selectedItem, for: .normal)
            bannerView.anyModelButton.setTitle("Any model", for: .normal)
        case .model:
            bannerView.anyModelButton.setTitle(selectedItem, for: .normal)
            bannerView.anyMakeButton.setTitle("Any make", for: .normal)
        }
        homeListVM.filterSections.append(contentsOf: updatedList)
        homeListVM.filterSections.append(contentsOf: updatedData)
        tableView.reloadData()
    }
    
    func filterCleared() {
        homeListVM.isFilterSelected = false
        bannerView.resetButtonTitles()
        tableView.reloadData()
    }
    
}
