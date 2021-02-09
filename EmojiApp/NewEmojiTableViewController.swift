//
//  NewEmojiTableViewController.swift
//  EmojiApp
//
//  Created by Danis on 09.02.2021.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {

    var emoji = Emoji(emoji: "", name: "", info: "", isFavourite: false)
 
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var infoTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emojiTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSabeButtonState()
        updateUI()
    }

    func updateSabeButtonState(){
        let emojiText = emojiTF.text ?? ""//если его нет то = пустой строке
        let nameText = nameTF.text ?? ""
        let infoText = infoTF.text ?? ""
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !infoText.isEmpty
    }
    
    func updateUI() {
        emojiTF.text = emoji.emoji
        nameTF.text = emoji.name
        infoTF.text = emoji.info
        
    }
    
    
    @IBAction func textChanged(_ sender: UITextField) {
    updateSabeButtonState()
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        let emoji = emojiTF.text ?? ""
        let name = nameTF.text ?? ""
        let info = infoTF.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, info: info, isFavourite: self.emoji.isFavourite)
    }
    
}
