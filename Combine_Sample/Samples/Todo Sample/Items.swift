//
//  Items.swift
//  SwiftUI_Sample
//
//  Created by 服部翼 on 2021/02/04.
//

import Foundation

struct Items: Hashable {
    let item: String
    let date: String
}



struct MockItem {
    let a = Items(item: "taro", date: "2011/12/26")
    let b = Items(item: "jiro", date: "2007/05/02")
    let c = Items(item: "saburo", date: "2002/11/06")
    let items: [Items]
    
    init() {
        self.items = [a,b,c]
    }
}
