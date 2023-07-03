//
//  FormMultiComboBox.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 22.06.23.
//

import SwiftUI

struct CheckableText: View {
    var text: String
    @Binding var checked: Bool
    @State var color = Color.clear
    @State var opacity = 0.0

    var body: some View {
        Button(action: {
            Task {
                withAnimation {
                    color = .blue
                    checked.toggle()
                    opacity = checked ? 1.0 : 0.0
                    //color = .black
                }
                try await Task.sleep(nanoseconds: 100_000_000)
                withAnimation {
                    color = .clear
                }
            }
        }) {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: "checkmark")
                    .opacity(opacity)
            }
        }
//        .listRowBackground(Color(checked ? UIColor.systemFill : UIColor.systemBackground).animation(.easeInOut)) //<==Here
        .listRowBackground(color.animation(.easeInOut)) //<==Here
//        .transition(.opacity.animation(.easeInOut(duration: 0.2)))
        .onAppear {
            opacity = checked ? 1.0 : 0.0
        }
    }
}
struct FormMultiComboBoxList: View {
    let items = (1...100).map { "Item \($0)" }
    @Binding var selectedItems: Set<String>
    
    var body: some View {
        List(items, id: \.self) { item in
            CheckableText(text: item, checked: .init(
                get: { selectedItems.contains(item) },
                set: {
                    if $0 {
                        selectedItems.insert(item)
                    }
                    else {
                        selectedItems.remove(item)
                    }
                    print(selectedItems)
                }))
//            Toggle(isOn: .init(
//                get: { selectedItems.contains(item) },
//                set: {
//                    if $0 {
//                        selectedItems.insert(item)
//                    }
//                    else {
//                        selectedItems.remove(item)
//                    }
//                    print(selectedItems)
//                })) {
//                Text(item)
//            }
        }
    }
}

struct FormMultiComboBox: View {
    var items = (1...100).map { "Item Item Item Item Item Item \($0)" }
    @Binding var selectedItems: Set<String>
    
    var body: some View {
        NavigationLink(destination: FormMultiComboBoxList(selectedItems: $selectedItems)) {
            Text(selectedItems.isEmpty ? "none" : selectedItems.sorted(by: <).joined(separator: ", "))
        }
    }
}

//#Preview {
//    NavigationView {
//        FormMultiComboBox(, selectedItems: <#Binding<Set<String>>#>)
//    }
//}
