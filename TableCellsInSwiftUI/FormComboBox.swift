//
//  FormComboBox.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 22.06.23.
//

import SwiftUI

struct FormComboBox: View {
    var items = (1...100).map { "Item Item Item Item Item Item \($0)" }
    @Binding var value: String

    var body: some View {
        Picker("Cars", selection: $value) {
            ForEach(items, id: \.self) {
                Text($0)
            }
        }
    }
}

//#Preview {
//    NavigationView {
//        List {
//            Text("Please correct all errors before proceeding")
//                .foregroundColor(.white)
//                .padding(4)
//                .frame(maxWidth: .infinity)
//                .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.red))
//            FormField(label: "label", error: "error") {
//                FormComboBox(value: .constant("Item 22"))
//            }
//            FormEditField(fieldModel: FieldModel2(text: "Hi", error: nil))
//            FormEditField(fieldModel: FieldModel2(text: "Hi", error: "Does not contain 'abc'"))
//
//            FormField(label: "FormMultiComboBox", error: nil) {
//                FormMultiComboBox()
//            }
//
//            FormEditorField(fieldModel: FieldModel2(text: "Editor", error: nil))
//        }
//    }
//    .listStyle(.plain)
//}
