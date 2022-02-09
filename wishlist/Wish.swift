//
//  Wish.swift
//  wishlist
//
//  Created by Keyaki Sato on 2022/01/15.
//

import Foundation
import RealmSwift

/*
class DeleteList: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var price = ""

}
 */


class nWishList: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var date = Date()
    @objc dynamic var stts = "0"
}
