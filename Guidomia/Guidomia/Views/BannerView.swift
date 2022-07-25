//
//  BannerView.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import UIKit

class BannerView : UIView {
    
    @IBOutlet weak var anyMakeButton: UIButton!
    @IBOutlet weak var anyModelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configView()
    }
    
    func configView() {
        guard let view  = self.loadNib(nibName: "BannerView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func resetButtonTitles()
    {
        anyMakeButton.setTitle("Any make", for: .normal)
        anyModelButton.setTitle("Any model", for: .normal)
    }
}
