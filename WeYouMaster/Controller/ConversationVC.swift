//
//  ConversationVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class ConversationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getConversation().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell") as? ConversationCell {
            cell.updateView(conversation: DataService.instance.getConversation()[indexPath.row])
            return cell
        }else {
            return ConversationCell()
        }
    }
    

    @IBOutlet weak var tvConversation: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tvConversation.dataSource = self
        tvConversation.delegate = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let StoryBoard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC  = StoryBoard.instantiateViewController(withIdentifier:"ChatVC" ) as? ChatVC
        self.navigationController?.pushViewController(DVC!, animated: true)
        
    }

   

}
