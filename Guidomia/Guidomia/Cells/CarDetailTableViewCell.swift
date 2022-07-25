//
//  CarDetailTableViewCell.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var proDetails: UILabel!
    @IBOutlet var conDetails: UILabel!
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var consLabel: UILabel!
    
    public static var identifier : String
    {
        return String(describing: CarDetailTableViewCell.self)
    }
    
    var prosArray : [String]! {
        didSet {
            setUpDataForPros()
        }
    }
    var consArray : [String]! {
        didSet {
            setUpDataForCons()
        }
    }
    
    func setUpDataForPros()
    {
        if prosArray.isEmpty
        {
            prosLabel.isHidden = true
        } else {
            prosLabel.isHidden = false
            let proArray = prosArray.filter({ $0.isEmpty == false })
            proDetails.attributedText = NSAttributedString().formattedAttributedString(dataArray: proArray)
        }
    }
    
    func setUpDataForCons()
    {
        if consArray.isEmpty
        {
            consLabel.isHidden = true
        } else {
            consLabel.isHidden = false
            let conArray = consArray.filter({ $0.isEmpty == false })
            conDetails.attributedText = NSAttributedString().formattedAttributedString(dataArray: conArray)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
