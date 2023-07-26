//
//  ViewController.swift
//  Chat Bot
//
//  Created by IPS-108 on 26/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtMsg: UITextField!

    var chatMessages = [ChatMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self

        let defaultBotMessage = ChatMessage(text: "How can I help you?", isUserMessage: false)
        chatMessages.append(defaultBotMessage)

        tblView.reloadData()
    }

    @IBAction func msgSend(_ sender: UIButton) {
        if let message = txtMsg.text, !message.isEmpty {
            chatMessages.append(ChatMessage(text: message, isUserMessage: true))
            tblView.reloadData()
            tblView.scrollToRow(at: IndexPath(row: chatMessages.count - 1, section: 0), at: .bottom, animated: true)
            txtMsg.text = ""


            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let botReply = "Currently I can not capable to reply to it as I am under trainning, please come after some time"
                self.chatMessages.append(ChatMessage(text: botReply, isUserMessage: false))
                self.tblView.reloadData()
                self.tblView.scrollToRow(at: IndexPath(row: self.chatMessages.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTBVC
        let message = chatMessages[indexPath.row]

        cell.txtUser.isHidden = !message.isUserMessage
        cell.txtBot.isHidden = message.isUserMessage
        cell.txtUser.text = message.text
        cell.txtBot.text = message.text

        return cell
    }
}

struct ChatMessage {
    let text: String
    let isUserMessage: Bool
}

