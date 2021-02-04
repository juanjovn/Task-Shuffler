//
//  GifFileProvider.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation
import ImageIO

class GifFileProvider {
    let catsURL = URL(string: "https://cataas.com/cat/gif")!
    init() {
        
    }
    
    func downloadGif () {
        let task = URLSession.shared.downloadTask(with: catsURL) { localURL, urlResponse, error in
            if let localURL = localURL {
                if let string = try? String(contentsOf: localURL) {
                    print(string)
                }
            }
        }

        task.resume()
    }
}
