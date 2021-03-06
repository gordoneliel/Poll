//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Eliel Gordon on 9/17/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        
        let storyboard = UIStoryboard(storyboard: .main)
        
        switch presentationStyle {
        case .compact:
            let viewController: PollsViewController = storyboard.instantiate()
            viewController.delegate = self
            presentOn(view: viewController)
        case .expanded:
            let viewController: CreatePollViewController = storyboard.instantiate()
            presentOn(view: viewController)

        }
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Present the view controller appropriate for the conversation and presentation style.
        let storyboard = UIStoryboard(storyboard: .main)
        
        switch presentationStyle {
        case .compact:
            let viewController: PollsViewController = storyboard.instantiate()
            viewController.delegate = self
            presentOn(view: viewController)
        case .expanded:
            let viewController: CreatePollViewController = storyboard.instantiate()
            presentOn(view: viewController)
        }
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
}

extension MessagesViewController: PollsViewControllerDelegate {
    func pollsViewControllerDidSelectAdd(_ controller: PollsViewController) {
        requestPresentationStyle(.expanded)
    }
}

extension MessagesViewController: Presentable {}
