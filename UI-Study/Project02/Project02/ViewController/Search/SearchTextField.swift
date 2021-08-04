//
//  SearchTextField.swift
//  Project02
//
//  Created by JH on 2021/07/27.
//

import UIKit

@IBDesignable
final class SearchTextField: UITextField {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        attributedPlaceholder = "오늘의집 통합검색".placeholder(color: .lightGray)
        accessibilityHint = "검색어를 입력해주세요."
        returnKeyType = .search
        let searchIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        searchIconImageView.image = UIImage(systemName: "magnifyingglass")
       
        if let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray, renderingMode: .alwaysTemplate) {
            searchIconImageView.image = image
        }
        
        searchIconImageView.backgroundColor = .clear
        searchIconImageView.contentMode = .center
        
        searchIconImageView.tintColor = .lightGray
        leftView = searchIconImageView
        
        leftViewMode = .always
        rightViewMode = .whileEditing
        layer.cornerRadius = 16
        borderStyle = .none
        backgroundColor = .gray
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 16
        rect.size.width += 8
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 16 + 24 + 8, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}
