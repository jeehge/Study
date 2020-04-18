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
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func applyFilterButtonPressed() {
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
        self.photoImageView.image = image
        self.applyFileterButton.isHidden = false
    }
}
