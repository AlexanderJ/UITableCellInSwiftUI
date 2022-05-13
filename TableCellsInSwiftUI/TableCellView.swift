//
//  TableCellView.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 13.05.22.
//

import SwiftUI
import UIKit

struct FieldModel {
    var mode: Int = 0
    var title: String
    var subtitle: String
}

class CustomCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var textView: UITextView?
}

let nib = UINib(nibName: "CustomCell", bundle: nil)

struct TableCellView: UIViewRepresentable {
    typealias UIViewType = UITableViewCell

    var fieldModel: FieldModel
    
    func makeUIView(context: Context) -> UITableViewCell {
        var style = UITableViewCell.CellStyle.default
        switch fieldModel.mode % 5 {
        case 0: style = .default
        case 1: style = .subtitle
        case 2: style = .value1
        case 3: style = .value2
        case 4:
            if let cell = Bundle.main.loadNibNamed("CustomCell", owner: nil, options: nil)?.first as? CustomCell {
                cell.textField?.text = fieldModel.title
                cell.textView?.text = fieldModel.subtitle
                return cell
            }
            
        default: style = .default
        }
        let cell = UITableViewCell(style: style, reuseIdentifier: nil)
        return cell
    }
    
    func updateUIView(_ uiView: UITableViewCell, context: Context) {
        uiView.textLabel?.text = fieldModel.title
        uiView.detailTextLabel?.text = fieldModel.subtitle
    }
}
