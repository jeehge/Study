//
//  HorizontalMenu.swift
//  Project02
//
//  Created by JH on 2021/07/28.
//

import UIKit
import Then

protocol HorizontalMenuDelegate {
    func didSelectAtIndex(index: Int)
}

class HorizontalMenu: UIScrollView ,UIScrollViewDelegate {
    
    var items: [String]? {
        didSet{
            setup()
        }
    }
    
    var emidelegate: HorizontalMenuDelegate?
    
    var selectedMenu = UILabel().then {
        $0.backgroundColor = .black
        $0.text = ""
    }
    
    var titleColor: UIColor?
    var titleSize: CGFloat?
    var selctedMenuColor: UIColor?
    var buttons = [UIButton]()
    
    // MARK: - Initalize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var selectedMenuXAxis: NSLayoutConstraint!
    var selectedMenuWidth: NSLayoutConstraint!
    var selectedMenuHeight: CGFloat = 2
    
    func setup() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
        
        addSubview(selectedMenu)
        selectedMenu.backgroundColor = (selctedMenuColor != nil) ? selctedMenuColor : .black
        
        selectedMenu.heightAnchor.constraint(equalToConstant: selectedMenuHeight).isActive = true
        
        selectedMenuWidth = selectedMenu.widthAnchor.constraint(equalToConstant: estimateFrameForText((items?.first)!).width + 10)
        selectedMenuWidth.isActive = true
        
        selectedMenuXAxis = selectedMenu.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0)
        selectedMenuXAxis.isActive = true
        
        selectedMenu.topAnchor.constraint(equalTo: self.topAnchor,
                                          constant: (self.frame.height - selectedMenuHeight)).isActive = true
        
        var xCordinate:Double = 0.0
        var index = 0
        
        for text in items! {
            let width = estimateFrameForText(text).width + 10
            let buttonFrame = CGRect(x: xCordinate, y: 0.0, width: Double(width), height: Double(self.frame.height))
            
            let button = UIButton(frame: buttonFrame)
            button.frame.origin.y = 0
            button.titleLabel?.textAlignment = .center
            
            let titlColor = (titleColor != nil) ? titleColor : .black
            button.setTitleColor(titlColor, for: [])
            
            let fontSize = (titleSize != nil) ? titleSize : 17
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
            button.setTitle(text, for: .normal)
            button.tag = index
            button.backgroundColor = .clear
            index += 1
            self.addSubview(button)
            
            button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
            self.buttons.append(button)
            
            xCordinate = (xCordinate + Double(width) ) + 10.0
        }
        contentSize = CGSize(width: Double(xCordinate), height: Double(self.frame.height))
    }
    
    fileprivate func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    @objc
    func buttonClicked(sender:UIButton) {
        emidelegate?.didSelectAtIndex(index: sender.tag)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.selectedMenuXAxis.constant = sender.frame.origin.x
            self.selectedMenuWidth.constant = sender.frame.size.width
            self.layoutIfNeeded()
        }) { (done) in
            
        }
    }
    
    func selectItemWithIndex(index:Int) {
        if let button: UIButton = buttons[index] as? UIButton {
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                self.selectedMenuXAxis.constant = button.frame.origin.x
                self.selectedMenuWidth.constant = button.frame.size.width
                self.scrollRectToVisible(button.frame, animated: true)
                self.layoutIfNeeded()
            }) { (done) in
                
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y != 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
