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
        VStack {
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    Text(item.title)
                }
            }
            
            Button("Swift Article acquisition") {
                viewModel.tappedArtcleBtn.send(Void())
            }
        }
    }
}

struct QiitaListView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaListView()
    }
}
