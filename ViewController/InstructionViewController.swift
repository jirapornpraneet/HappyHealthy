//
//  ZoomImageViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 23/01/2562 BE.
//  Copyright © 2560 bigdata. All rights reserved.
//

import UIKit
import ImageSlideshow

class InstructionViewController: UIViewController {

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBOutlet var slideshow: ImageSlideshow!

    override func viewDidLoad() {
        super.viewDidLoad()

        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageIndicatorPosition = PageIndicatorPosition(vertical: .under)
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.black
        slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.contentScaleMode = UIView.ContentMode.scaleToFill
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }

        let localSource = [ImageSource(imageString: "InstructionBloodPressure.png")!,
                           ImageSource(imageString: "InstructionDiabetes.png")!,
                           ImageSource(imageString: "InstructionDiabetes2.png")!,
                           ImageSource(imageString: "InstructionKidney")!,
                           ImageSource(imageString: "InstructionDrink")!,
                           ImageSource(imageString: "InstructionEat")!]

        slideshow.setImageInputs(localSource)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(InstructionViewController.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }

    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "คำแนะนำสุขภาพ"
    }
}
