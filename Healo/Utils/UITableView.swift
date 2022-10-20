//
//  UITableView.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit

extension ChatListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

}
