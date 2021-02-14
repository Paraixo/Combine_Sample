//
//  QiitaListView.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import SwiftUI
import Combine

struct QiitaListView: View {
    
    @ObservedObject private var viewModel = QiitaListViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct QiitaListView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaListView()
    }
}
