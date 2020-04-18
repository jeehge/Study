//
//  FiltersService.swift
//  StudyProject
//
//  Created by JH on 2020/04/18.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift

class FiltersService {

    // CIFilter 적용하기 위해서는 CIContext가 필요
    private var context: CIContext

    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")! // CIFilter 생성
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) { // CIImage 생성
            // 스위프트는 자동적으로 초기의 "CFFloat" 값을 "NSNumber" 객체로 변환
            // "setValue(value:forKey:)" 와 함께 사용하기에 적합
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                // CIImage 로부터 직접 생성하는 것 대신 새롭게 생성된 CGImage로 부터 UIImage를 생성하기 위해 사용
                // 이 부분에서, Objective-C 에서는 메모리 관리 문제가 있었는데, 스위프트에서는 ARC 가 자동적으로 코어 파운데이션 객체들을 릴리즈 해줄 수 있다고 합니다
                let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                
                completion(processedImage)
            }
        }
    }
}



