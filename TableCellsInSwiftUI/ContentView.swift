//
//  ContentView.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 13.05.22.
//

import SwiftUI

struct ContentView: View {
    let models : [FieldModel] = {
        var prefix = [
            FieldModel(title: "abc", subtitle: "sub abc"),
            FieldModel(title: "def", subtitle: "sub def")]
        prefix.append(contentsOf: (1...30).map {
            FieldModel(mode: $0, title: "abc \($0)", subtitle: "sub abc \($0)")
        })
        return prefix
    }()

    var body: some View {
        List {
            Text("Hello, world!")
                .background(Color.yellow)
            ForEach(models, id: \.title) {
                TableCellView(fieldModel: $0)
                    .padding(-8)
                    //.background(Color.yellow)
                    //.background(Color.red)
            }
        }
        .listStyle(.plain) //automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
