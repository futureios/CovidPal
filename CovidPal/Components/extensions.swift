//
//  extensions.swift
//  CovidPal
//
//  Created by Mac OS on 8/22/20.
//  Copyright © 2020 Mac OS. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
}

extension UIButton
{
    func addBlurEffect()
    {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        blur.layer.cornerRadius = 10
        blur.clipsToBounds = true
        self.insertSubview(blur, at: 0)
        if let imageView = self.imageView{
            self.bringSubviewToFront(imageView)
        }
    }
}

extension UIView
{
    func addBlurEffectToView()
    {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        blur.layer.cornerRadius = 15
        blur.clipsToBounds = true
        self.insertSubview(blur, at: 0)
    }
    
    func addBlurEffectToViewNo()
    {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        blur.clipsToBounds = true
        self.insertSubview(blur, at: 0)
    }
}

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
