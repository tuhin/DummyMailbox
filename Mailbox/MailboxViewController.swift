//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Tuhin Kumar on 11/3/14.
//  Copyright (c) 2014 Eunoia. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    var location: CGPoint!
    var velocity: CGPoint!
    var translation: CGPoint!
    var originalCenter: CGPoint!
    var leftCenter: CGPoint!
    var rightCenter: CGPoint!
    @IBOutlet weak var laterIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    var originalLaterX: CGFloat!
    var originalListX: CGFloat!
    var originalArchiveX: CGFloat!
    var originalDeleteX: CGFloat!
    @IBOutlet weak var chooseListView: UIImageView!
    @IBOutlet weak var chooseSnoozeView: UIImageView!
    @IBOutlet weak var feedView: UIView!
    var edgeLocation: CGPoint!
    var edgeVelocity: CGPoint!
    var edgeTranslation: CGPoint!
    var edgeOriginalCenter: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = feedImageView.image!.size
        chooseListView.alpha = 0
        chooseSnoozeView.alpha = 0
        laterIconView.alpha = 0
        listIconView.alpha = 0
        archiveIconView.alpha = 0
        deleteIconView.alpha = 0
        originalLaterX = laterIconView.center.x
        originalListX = listIconView.center.x
        originalArchiveX = archiveIconView.center.x
        originalDeleteX = deleteIconView.center.x
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        feedView.addGestureRecognizer(edgeGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMessageSwipe(sender: UIPanGestureRecognizer) {
        
        location = sender.locationInView(view)
        velocity = sender.velocityInView(view)
        translation = sender.translationInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            originalCenter = messageImageView.center
            rightCenter = laterIconView.center
            leftCenter = archiveIconView.center

        } else if sender.state == UIGestureRecognizerState.Changed {
            messageImageView.center.x = translation.x + originalCenter.x
        
            // Left swipe
            if  (translation.x > 160) {
                self.archiveIconView.alpha = 0
                deleteIconView.center.x = leftCenter.x + (translation.x) - 60
                self.messageBackgroundView.backgroundColor = UIColor (red:0.89, green:0.32, blue:0.05,alpha:1.0)
                
                UIView .animateWithDuration(0.5, animations: { () -> Void in
                    self.deleteIconView.alpha = 1
                })
                
            } else if (translation.x > 60) {
                
                self.deleteIconView.alpha = 0
                archiveIconView.center.x = leftCenter.x + (translation.x) - 60
                deleteIconView.center.x = leftCenter.x + (translation.x) - 60
                self.messageBackgroundView.backgroundColor = UIColor (red:0.31, green:0.75, blue:0.19,alpha:1.0)
                
                UIView .animateWithDuration(0.5, animations: { () -> Void in
                    self.archiveIconView.alpha = 1
                })
            } else if (translation.x < -160) {
                self.laterIconView.alpha = 0
                listIconView.center.x = rightCenter.x + (translation.x) + 60
                self.messageBackgroundView.backgroundColor = UIColor (red:0.58, green:0.45, blue:0.27,alpha:1.0)
                
                UIView .animateWithDuration(0.5, animations: { () -> Void in
                    self.listIconView.alpha = 1
                })
                
            } else if (translation.x < -60) {
                
                self.listIconView.alpha = 0
                laterIconView.center.x = rightCenter.x + (translation.x) + 60
                listIconView.center.x = rightCenter.x + (translation.x) + 60
                self.messageBackgroundView.backgroundColor = UIColor (red:0.93, green:0.71, blue:0.05,alpha:1.0)
                
                UIView .animateWithDuration(0.5, animations: { () -> Void in
                    self.laterIconView.alpha = 1
                })
                } else {
                
            }
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            // It ended!
            if  (translation.x > 160) {
                println("you would have trashed this")
                
                UIView .animateWithDuration(0.3, animations: { () -> Void in
                    self.messageImageView.center.x = 600
                    self.deleteIconView.center.x = 600
                }, completion: { (Bool) -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor (red:0.85, green:0.85, blue:0.85,alpha:1.0)
                    UIView .animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = self.originalCenter.x
                        self.archiveIconView.center.x = self.originalArchiveX
                        self.deleteIconView.center.x = self.originalDeleteX
                        self.listIconView.center.x = self.originalListX
                        self.laterIconView.center.x = self.originalListX
                        self.laterIconView.alpha = 0
                        self.listIconView.alpha = 0
                        self.archiveIconView.alpha = 0
                        self.deleteIconView.alpha = 0
                    })
                })
                
            } else if (translation.x > 60) {
                println("you would have archived this")
                UIView .animateWithDuration(0.3, animations: { () -> Void in
                    self.messageImageView.center.x = 600
                    self.archiveIconView.center.x = 600
                    }, completion: { (Bool) -> Void in
                        self.messageBackgroundView.backgroundColor = UIColor (red:0.85, green:0.85, blue:0.85,alpha:1.0)
                        UIView .animateWithDuration(0.3, animations: { () -> Void in
                            self.messageImageView.center.x = self.originalCenter.x
                            self.archiveIconView.center.x = self.originalArchiveX
                            self.deleteIconView.center.x = self.originalDeleteX
                            self.listIconView.center.x = self.originalListX
                            self.laterIconView.center.x = self.originalListX
                            self.laterIconView.alpha = 0
                            self.listIconView.alpha = 0
                            self.archiveIconView.alpha = 0
                            self.deleteIconView.alpha = 0
                        })
                })
                
            } else if (translation.x < -160) {
                println("you would have listed this")
                UIView .animateWithDuration(0.3, animations: { () -> Void in
                    self.messageImageView.center.x = -600
                    self.listIconView.center.x = -600
                    self.chooseListView.alpha = 1
                    })
                
            } else if (translation.x < -60) {
                println("you would have snoozed this")
                UIView .animateWithDuration(0.3, animations: { () -> Void in
                    self.messageImageView.center.x = -600
                    self.laterIconView.center.x = -600
                    self.chooseSnoozeView.alpha = 1
                    })
                
            } else {
                
                println("you wasted energy")
                self.messageBackgroundView.backgroundColor = UIColor (red:0.85, green:0.85, blue:0.85,alpha:1.0)
                
                UIView .animateWithDuration(0.3, animations: { () -> Void in
                    self.messageImageView.center.x = self.originalCenter.x
                    self.archiveIconView.center.x = self.originalArchiveX
                    self.deleteIconView.center.x = self.originalDeleteX
                    self.listIconView.center.x = self.originalListX
                    self.laterIconView.center.x = self.originalListX
                    self.laterIconView.alpha = 0
                    self.listIconView.alpha = 0
                    self.archiveIconView.alpha = 0
                    self.deleteIconView.alpha = 0
                })

            }
        }
    }
    
    
    @IBAction func listWasTapped(sender: UITapGestureRecognizer) {
        chooseListView.alpha = 0
        resetVariables()
    }
    
    
    @IBAction func snoozeWasTapped(sender: UITapGestureRecognizer) {
        chooseSnoozeView.alpha = 0
        resetVariables()
    }
    
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        
        edgeLocation = sender.locationInView(view)
        edgeVelocity = sender.velocityInView(view)
        edgeTranslation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            edgeOriginalCenter = feedView.center

            
        } else if sender.state == UIGestureRecognizerState.Changed {
            feedView.center.x = edgeOriginalCenter.x + edgeTranslation.x
            
        }  else if sender.state == UIGestureRecognizerState.Ended {
            
            UIView .animateWithDuration(0.4, animations: { () -> Void in
                self.feedView.center.x = 440
            })
        }
        
    }
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        if self.feedView.center.x < 300 {
        UIView .animateWithDuration(0.4, animations: { () -> Void in
            self.feedView.center.x = 440
        })
        } else {
            UIView .animateWithDuration(0.4, animations: { () -> Void in
                self.feedView.center.x = 160
            })
        }
    }
    
    
    func resetVariables() {
        self.messageBackgroundView.backgroundColor = UIColor (red:0.85, green:0.85, blue:0.85,alpha:1.0)
        UIView .animateWithDuration(0.3, animations: { () -> Void in
            self.messageImageView.center.x = self.originalCenter.x
            self.archiveIconView.center.x = self.originalArchiveX
            self.deleteIconView.center.x = self.originalDeleteX
            self.listIconView.center.x = self.originalListX
            self.laterIconView.center.x = self.originalListX
            self.laterIconView.alpha = 0
            self.listIconView.alpha = 0
            self.archiveIconView.alpha = 0
            self.deleteIconView.alpha = 0
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
