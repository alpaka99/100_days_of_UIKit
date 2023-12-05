//
//  PageViewController.swift
//  UIKit_day_108(UIPagePrgrogressTimer)
//
//  Created by user on 12/5/23.
//

import Foundation
import UIKit
import SwiftUI

struct PageViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return TimerPageViewController(pages: [
            PageVC(index: 0, image: "frame1"),
            PageVC(index: 1, image: "frame2"),
            PageVC(index: 2, image: "frame3"),
            PageVC(index: 3, image: "frame4"),
            PageVC(index: 3, image: "frame5"),
            PageVC(index: 3, image: "frame6"),
        ])
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class PageVC: UIViewController {
  
  let pageIndex: Int
  
  init(index: Int, image: String) {
    pageIndex = index
    super.init(nibName: nil, bundle: nil)
    view = UIImageView(image: UIImage(named: image))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class TimerPageViewController: UIPageViewController {
  
  let pages: [PageVC]
  
  let timerProgress = UIPageControlTimerProgress(preferredDuration: 3)
  let pageControl = UIPageControl()
  
  var suspensionTimer: Timer?
  
  init(pages: [PageVC]) {
    self.pages = pages
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
  }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    self.dataSource = self
    self.setViewControllers([pages.first!], direction: .forward, animated: true)
    
    addPagerControlGradient()
    configurePageControl()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    timerProgress.resumeTimer()
  }
  
  func configurePageControl() {
    timerProgress.delegate = self
    timerProgress.resetsToInitialPageAfterEnd = true
    
    pageControl.numberOfPages = pages.count
    pageControl.progress = timerProgress
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(pageControl)
    NSLayoutConstraint.activate([
      pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
  }
  
  func addPagerControlGradient() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
    gradient.startPoint = .zero
    gradient.endPoint = CGPoint(x: 0, y: 1)
    gradient.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100)
    self.view.layer.addSublayer(gradient)
  }
}

extension TimerPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    let currentIndex = getPageIndex(from: viewController)
    let previousIndex = currentIndex - 1 >= 0 ? currentIndex - 1 : pages.count - 1
    return pages[previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    let currentIndex = getPageIndex(from: viewController)
    let nextIndex = currentIndex + 1 <= pages.count - 1 ? currentIndex + 1 : 0
    return pages[nextIndex]
  }
    
  func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    timerProgress.pauseTimer()
    suspensionTimer?.invalidate()
    
    suspensionTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
      self.timerProgress.resumeTimer()
    }
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    pageControl.currentPage = getPageIndex(from: pageViewController.viewControllers?.first)
  }
  
  func getPageIndex(from viewController: UIViewController?) -> Int {
    (viewController as? PageVC)?.pageIndex ?? 0
  }
}

extension TimerPageViewController: UIPageControlTimerProgressDelegate {
  
  func pageControlTimerProgress(_ progress: UIPageControlTimerProgress, shouldAdvanceToPage page: Int) -> Bool {
    self.setViewControllers([pages[page]], direction: .forward, animated: true, completion: nil)
    return true
  }
}

//#Preview {
//  TimerPageViewController(
//    pages: [
//        PageVC(index: 0, image: "frame1"),
//        PageVC(index: 1, image: "frame2"),
//        PageVC(index: 2, image: "frame3"),
//        PageVC(index: 3, image: "frame4"),
//        PageVC(index: 3, image: "frame5"),
//        PageVC(index: 3, image: "frame6"),
//    ])
//}

