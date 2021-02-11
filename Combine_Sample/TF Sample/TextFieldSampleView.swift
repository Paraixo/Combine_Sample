//
//  TextFieldSampleView.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/12.
//

import SwiftUI

struct TextFieldSampleView: View {
    @ObservedObject var viewModel = TFSViewModel()
    
    var body: some View {
        VStack {
            TextField("パスワード",
                      text: $viewModel.input.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("パスワード繰り返して！",
                      text: $viewModel.input.repeatedPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                print("押されたよ")
            }) {
                Text("パスワードが一緒だと押せるよ！")
            }.disabled(!viewModel.output.validatedPassword)
        }
    }
    
}

struct TextFieldSampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldSampleView()
    }
}
