//
//  CustomForm.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 29.06.23.
//

import SwiftUI

struct CustomForm: View {
    @State var fields: [FieldModel2] = (0..<100).map {
        FieldModel2(
            label: "Label \($0*$0)",
            text: "Hi \($0)",
            error: Int.random(in: 0...2) == 0 ? "Some error" : nil)
    }

    @ViewBuilder func create(fieldModel: ObservedObject<FieldModel2>) -> some View {
        switch fieldModel.wrappedValue.type {
        case .edit: TextField(fieldModel.wrappedValue.label, text: fieldModel.projectedValue.text)
        case .editor: TextEditor(text: fieldModel.projectedValue.text)
        case .multiSelect: FormMultiComboBox(selectedItems: fieldModel.projectedValue.selection)
        case .singleSelect: FormComboBox(items: ["Item 1", "Item 29"], value: fieldModel.projectedValue.text)
        case .date: DatePicker(fieldModel.wrappedValue.label, selection: fieldModel.projectedValue.date)
                //.tint(.yellow)
                //.background(Color.green)
        }
    }

    var body: some View {
        NavigationView {
            List {
                Text("Please correct all errors before proceeding")
                    .foregroundColor(.white)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.red))
                
                ForEach(fields, id: \.label) { field in
                    FormField(fieldModel: field) { observedField, _ in
                        create(fieldModel: observedField)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    CustomForm()
}
