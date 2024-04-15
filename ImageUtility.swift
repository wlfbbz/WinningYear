//
//  ImageUtility.swift
//  WinningYear
//
//  Created by Barbara on 15/03/2024.
//

import UIKit

struct ImageUtility {
    static func getBase64StringForImage(named imageName: String) -> String? {
        guard let image = UIImage(named: imageName) else {
            return nil
        }

        if let data = image.pngData() {
            let base64String = data.base64EncodedString(options: .lineLength64Characters)
            return base64String
        }

        return nil
    }
}
