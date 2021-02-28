//
//  MailController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 7/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation
import MessageUI

class MailController: ViewController, MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["juanjovn@gmail.com"])
            mail.setSubject("Suggestions about Task Shuffler".localized())

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        //Remove controller from parent VC (SettingsVC)
        willMove(toParent: nil)
        removeFromParent()
    }
    
    deinit {
        //print("Deinit MailController ✉️")
    }
}
