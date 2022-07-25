//
//  NSAttributedString+FormattedAttributedString.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import UIKit

extension NSAttributedString
{
    func formattedAttributedString(dataArray: [String]) -> NSAttributedString
    {
        let defaultattributedString = NSMutableAttributedString(attributedString: self)
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .byTruncatingTail
        paraStyle.lineSpacing = 10.0
        defaultattributedString.addAttribute(.paragraphStyle, value: paraStyle,
                                       range: NSRange(location: 0, length: string.count))
        
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.orange
        attributes[.font] = UIFont.systemFont(ofSize: 18, weight: .heavy)
        let attributedString = NSAttributedString(string:  "•  ", attributes: attributes)
        let round = attributedString
        
        let eas = NSMutableAttributedString()
        dataArray.forEach {
            eas.append(round)
            eas.append(NSAttributedString(string: $0))
            eas.append(NSAttributedString(string: "\n"))
        }
        
        let combination = NSMutableAttributedString()
        combination.append(eas)
        return combination
    }
}
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(Int(round(million*10)/10))M"
        }
        else if thousand >= 1.0 {
            return "\(Int(round(thousand*10)/10))K"
        }
        else {
            return "\(self)"
        }
    }
}
extension UIView
{
    func loadNib(nibName: String) -> UIView? {
        let name = nibName
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
