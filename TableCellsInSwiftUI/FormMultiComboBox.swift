//
//  FormMultiComboBox.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 22.06.23.
//

import SwiftUI

struct FormMultiComboBoxList: View {
    let items = (1...100).map { "Item \($0)" }
    @Binding var selectedItems: Set<String>
    
    var body: some View {
        List(items, id: \.self) { item in
            Toggle(isOn: .init(
                get: { selectedItems.contains(item) },
                set: {
                    if $0 {
                        selectedItems.insert(item)
                    }
                    else {
                        selectedItems.remove(item)
                    }
                    print(selectedItems)
                })) {
                Text(item)
            }
        }
    }
}

struct FormMultiComboBox: View {
    var items = (1...100).map { "Item Item Item Item Item Item \($0)" }
    @State var selectedItems = Set<String>()
    
    var body: some View {
        NavigationLink(destination: FormMultiComboBoxList(selectedItems: $selectedItems)) {
            Text(selectedItems.isEmpty ? "none" : selectedItems.sorted(by: <).joined(separator: ", "))
        }
    }
}

#Preview {
    NavigationView {
        FormMultiComboBox()
    }
}
