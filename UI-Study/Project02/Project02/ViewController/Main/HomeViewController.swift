//
//  HomeViewController.swift
//  Project02
//
//  Created by JH on 2021/07/25.
//

import UIKit
import Tabman

class ColorsCell: UICollectionViewCell {
    
}

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var searchTextField: SearchTextField!
    @IBOutlet weak var menu: HorizontalMenu!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let items = ["인기", "사진", "집들이", "노하우", "전문가집들이", "질문과답변"]
    
    let colors:[UIColor] = [.red,.blue,.green,.brown,.yellow,.cyan]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.emidelegate = self
        menu.items = items
        collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK:- HorizontalMenu Delegates
extension HomeViewController: HorizontalMenuDelegate {
    func didSelectAtIndex(index: Int) {
        if index <= collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

//MARK:- scrollView Delegates
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let collection = scrollView as? UICollectionView {
            
            //calculating index of scrolled collectionview
            if collection.tag == 0 {
                let index = targetContentOffset.pointee.x / view.frame.width
                menu.selectItemWithIndex(index: Int(index))
            }
        }
    }
    
}
