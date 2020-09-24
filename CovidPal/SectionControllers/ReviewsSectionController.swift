//
//  ReviewsSectionController.swift
//  CovidPal
//
//  Created by Mac OS on 8/27/20.
//  Copyright © 2020 Mac OS. All rights reserved.
//

import IGListKit
import UIKit


class ReviewsSectionController: ListSectionController {
    
    private var model: ReviewsModel?

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: (collectionContext?.containerSize.width)!, height: ReviewsCell.cellSize(text: model!.review))
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ReviewsCell.self, for: self, at: index) as? ReviewsCell else{
            fatalError()
        }
        cell.fullNameText = model!.fullName
        cell.emailText = model!.email
        
        let newTime = (0 - model!.timeStamp)
        let unixTimeStamp: Double = Double(newTime) / 1000.0
        let date = Date(timeIntervalSince1970: unixTimeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss a"
        let timeString = dateFormatter.string(from: date)
        
        cell.setLabelsValue(review: model!.review, turnaroundTime: "\(model!.turnaroundTime) Days", timeStamp: "\(timeString)", profileUrl: model!.profilePic)

        return cell
    }

    override func didUpdate(to object: Any) {
        self.model = object as? ReviewsModel
    }
    
}
