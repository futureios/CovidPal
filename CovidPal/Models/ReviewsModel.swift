//
//  ReviewsModel.swift
//  CovidPal
//
//  Created by Mac OS on 8/27/20.
//  Copyright © 2020 Mac OS. All rights reserved.
//

import UIKit
import IGListKit

final class ReviewsModel: NSObject {

    let fullName: String
    let profilePic: String
    let email: String
    let review: String
    let turnaroundTime: String
    let timeStamp: Int64

    init(fullName: String, profilePic: String, email: String, review: String, turnaroundTime: String, timeStamp: Int64) {
        self.fullName = fullName
        self.profilePic = profilePic
        self.email = email
        self.review = review
        self.turnaroundTime = turnaroundTime
        self.timeStamp = timeStamp
    }

}

extension ReviewsModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }

}
