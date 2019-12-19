//
//  ImageStore.swift
//  P5_Quiz10
//
//  Created by Xinxin Liu on 22/11/2019.
//  Copyright © 2019 Xinxin Liu. All rights reserved.
//

import UIKit

class ImageStore: ObservableObject {
    
    @Published var imageCache = [URL: UIImage]()

    let loadingImage = UIImage(named: "loading")!
    let defaultImage = UIImage(named: "question")!
    
    func image(url: URL?) -> UIImage {
        
        guard let url = url else {
            return defaultImage
        }
        
        if let img = imageCache[url] {
            return img
        }
        
        self.imageCache[url] = loadingImage
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) {
                
                print(url)
                
                DispatchQueue.main.async {
                    self.imageCache[url] = img
                }
            }
        }
        return loadingImage
    }

}
