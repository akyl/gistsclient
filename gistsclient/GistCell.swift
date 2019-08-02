//
//  GistCell.swift
//  gistsclient
//

import UIKit

class GistCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
