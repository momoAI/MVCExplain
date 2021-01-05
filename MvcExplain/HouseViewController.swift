//
//  ViewController.swift
//  MvcExplain
//
//  Created by luxury on 2020/12/13.
//  Copyright © 2020 luxury. All rights reserved.
//

import UIKit

class HouseViewController: UITableViewController {
    @IBOutlet weak var addButton: UIBarButtonItem!
    let cellIdentifier = "houselist"
    
    var houses: [HouseItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reciveModelChange(noti:)), name: NSNotification.Name("houseChange"), object: nil)
        
        tableView.rowHeight = 50
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let items = [HouseItem(),
            HouseItem(),
            HouseItem()]
            

//            self.houses = items
//
            DispatchQueue.main.async {
//                self.tableView.reloadData()

                HouseStore.shared.append(newItems: items)
            }
            
        }
    }

    
    @IBAction func addItemItem(_ sender: Any) {
//        houses.append(HouseItem())
//        tableView.insertRows(at: [IndexPath(row: houses.count - 1, section: 0)], with: .bottom)
//        if houses.count > 5 {
//            addButton.isEnabled = false
//        }
        
        HouseStore.shared.append(item: HouseItem())
    }

    
    // MARK: -datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return houses.count
        return HouseStore.shared.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = houses[indexPath.row]
        let item = HouseStore.shared.item(at: indexPath.row)
        var cell: HouseListCell!
        let tmpcell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? HouseListCell
        if tmpcell == nil {
            cell = HouseListCell(style: .default, reuseIdentifier: cellIdentifier)
        } else {
            cell = tmpcell
        }
        cell.textLabel?.text = item.info
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { _, _, done in
//            self.houses.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            if self.houses.count < 6 {
//               self.addButton?.isEnabled = true
//            }
            
            HouseStore.shared.remove(at: indexPath.row)
            
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    @objc func reciveModelChange(noti: Notification) {
        if let dic = noti.object as? [String : HouseStore.ChangeBehavior], let behavior = dic["behavior"] {
            switch behavior {
            case let .add(indexs):
                let indexpaths = indexs.map{ IndexPath(row: $0, section: 0) }
                tableView.insertRows(at: indexpaths, with: .bottom)
            case let .remove(indexs):
                let indexpaths = indexs.map{ IndexPath(row: $0, section: 0) }
                tableView.deleteRows(at: indexpaths, with: .bottom)
            default:
                tableView.reloadData()
            }
            
            self.addButton?.isEnabled = HouseStore.shared.count < 6
        }
    }
    
    // MARK: -delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = houses[indexPath.row]
//        let dvc = HouseDetailViewController()
//        dvc.pkHouse = item.pkHouse
//        dvc.delegate = self
//        navigationController?.pushViewController(dvc, animated: true)
        
        let item = HouseStore.shared.item(at: indexPath.row)
        let dvc = HouseDetailViewController()
        dvc.item = item
        navigationController?.pushViewController(dvc, animated: true)
    }
}

extension HouseViewController: HouseDetailVcDelegate {
    func houseDetailVc(_ vc: HouseDetailViewController, delete pkHouse: UUID) {
        guard let index = (self.houses.firstIndex { $0.pkHouse == pkHouse }) else { return }
        self.houses.remove(at: index)
        self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        if self.houses.count < 6 {
           self.addButton?.isEnabled = true
        }
    }
}
