//
//  FiltersTableViewCell.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import UIKit

class ItemCollapseCell: UITableViewCell {

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var carImageView : UIImageView!
    @IBOutlet weak var bottomView : UIView!

    
    public static var identifier : String
    {
        return String(describing: ItemCollapseCell.self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateBottomView(status: Bool)
    {
        bottomView.isHidden = status
    }
    
    func setUpData(carData: CarDetail)
    {
        makeLabel.text = carData.make
        priceLabel.text = carData.carPrice
        carImageView.image = UIImage(named: carData.make.lowercased())
        setUpRatingView(score: carData.rating)
    }
    
    private func setUpRatingView(score: Int)
    {
        for i in 1...5
        {
            if let imageView = viewWithTag(i) as? UIImageView
            {
                if i <= score
                {
                    imageView.image = UIImage(systemName: "star.fill")
                } else {
                    imageView.image = UIImage(systemName: "star")
                }
            }
        }
    }
    
}
