//
//  ImageFilterViewController.swift
//  StudyProject
//
//  Created by JH on 2020/04/05.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit
import RxSwift

class ImageFilterViewController: UIViewController, ViewControllerFromStoryBoard {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var applyFileterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard   let navigationC = segue.destination as? UINavigationController,
                let photosCVC = navigationC.viewControllers.first as? PhotosCollectionViewController else {
            fatalError("Segue destination is not found")
        }
        
        // selectedPhoto 이벤트가 발생하면 UI를 업데이트 해라!
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func applyFilterButtonPressed() {
        // self.photoImageView.image 가 nil 이라면 return
        // guard let 조기탈출
        // guard let 이 성능을 떨어트린다고 하니 사용할 때 한번 더 생각해 보자!
        guard let sourceImage = self.photoImageView.image else {
            return
        }
        
        FiltersService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                DispatchQueue.main.async {
                    self.photoImageView.image = filteredImage
                }
        }).disposed(by: disposeBag)
        
//        FiltersService().applyFilter(to: sourceImage) { filteredImage in
//            DispatchQueue.main.async {
//                self.photoImageView.image = filteredImage
//            }
//        }
    }
    
    private func updateUI(with image: UIImage) {
        // 이미지가 있을 때 필터를 적용하는 버튼도 보이도록
        self.photoImageView.image = image
        self.applyFileterButton.isHidden = false
    }
}
