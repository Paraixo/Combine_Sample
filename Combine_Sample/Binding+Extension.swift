//
//  Binding+Extension.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/11.
//

import Foundation
import SwiftUI

extension Binding where Value == Int {
    func IntToStrDef(_ def: Int) -> Binding<String> {
        return Binding<String>(get:{
            return String(self.wrappedValue)
        }) { value in
            self.wrappedValue = Int(value) ?? def
        }
    }
    
}
