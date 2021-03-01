//
//  ViewController.swift
//  ProjectOne
//
//  Created by Surajit Dhara on 02/02/20.
//  Copyright © 2020 Surajit Dhara. All rights reserved.
//

import UIKit

import GoogleSignIn
import FSPagerView
class ReferClass:NSObject{
  public func publicFunc(){
    
    }
  open func openFunc(){
    
    }
}

public class publicClass{
    
}

class Implementing : NSObject{
   override func publicFunc(){
      var a = 10
    } // error
   override func openFunc(){
       var b = 20
    } // success
   
}


class ViewController: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate {
    
    
    @IBOutlet weak var pagerView: FSPagerView! {
          didSet {
              self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
          }
      }
      
      @IBOutlet weak var pageControl: FSPageControl! {
          didSet {
              self.pageControl.numberOfPages = self.imageNames.count
              self.pageControl.contentHorizontalAlignment = .center
              self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
              self.pageControl.hidesForSinglePage = true
          }
      }
    
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageControl.setImage(UIImage(named:"radious_gray"), for: .normal)
        self.pageControl.setImage(UIImage(named:"radious_yellow"), for: .selected)
        self.pageControl.itemSpacing = 22.0
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
        self.pagerView.isInfinite = !self.pagerView.isInfinite
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK:- FSPagerViewDataSource
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    
    // MARK:- Target Actions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            self.pageControl.itemSpacing = 6.0 + CGFloat(sender.value*10.0) // [6 - 16]
//            // Redraw UIBezierPath
//            if [3,4].contains(self.styleIndex) {
//                let index = self.styleIndex
//                self.styleIndex = index
//            }
        case 2:
            self.pageControl.interitemSpacing = 6.0 + CGFloat(sender.value*10.0) // [6 - 16]
        default:
            break
        }
    }

}

