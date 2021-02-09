//
//  EmojiTableViewController.swift
//  EmojiApp
//
//  Created by Danis on 09.02.2021.
//

import UIKit
class EmojiTableViewController: UITableViewController {

    var objects = [
        Emoji(emoji: "😘", name: "Love", info: "Keep", isFavourite: false),
        Emoji(emoji: "🥲", name: "Crying", info: "Keep", isFavourite: false),
        Emoji(emoji: "😙", name: "KOK", info: "Keep", isFavourite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Эмоджи справочник"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        guard  segue.identifier == "saveSegue" else {return}
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        }else{
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
        
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let  newEmojiVC = navigationVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
        
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        return cell
    }
  
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete//удаляет ячейку
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true//создает кнопку передвижения
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)//сохраняет удаленную
        objects.insert(movedEmoji, at: destinationIndexPath.row)//вставляет удаленную
        tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = favouriteAction(at: indexPath)
      
        return UISwipeActionsConfiguration(actions: [done])
        
    }
    
//    func doneAction(at indexPath:IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
//            self.objects.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            completion(true)
//        }
//        action.backgroundColor = .black
//        action.image = UIImage(systemName: "checkmark")
//        return action
//    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPink : .none
        action.image = UIImage(systemName: "heart")
        
     
        
    
        
        return action
    }
}
