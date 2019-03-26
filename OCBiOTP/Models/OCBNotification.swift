//
//  OCBNotification.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 12/9/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class OCBNotification {
//    var transactionId: NotificationChildData!
//    var toAccount: NotificationChildData!
//    var fromAccount: NotificationChildData!
//    var amount: NotificationChildData!
    var childs: [NotificationChildData]! = []
    var timeStammp: String!
}

struct NotificationChildData {
    var caption: String! = ""
    var data: String! = ""
    var color: String! = ""
}
