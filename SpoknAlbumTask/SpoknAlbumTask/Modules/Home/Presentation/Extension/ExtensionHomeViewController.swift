//
//  ExtensionHomeViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 12/01/2022.
//

import Foundation
import UIKit

//MARK: - Set Delegate and DataSource to overlayTableView which used just to render Skeltonview

extension HomeViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.startAnimateSkeltonCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    
    
}
