//
//  OnboardPageVC.swift
//  onboard_pageview
//
//  Created by Le Dang Dai Duong on 06/01/2018.
//  Copyright © 2018 Le Dang Dai Duong. All rights reserved.
//

import UIKit

class OnboardPageVC: UIPageViewController {
    
    private var pageControl = UIPageControl()
    
    private(set) lazy var onboardVCArray: [UIViewController] = {
        return [self.newOnboardVC(page: "PageOne"),
                self.newOnboardVC(page: "PageTwo"),
                self.newOnboardVC(page: "PageThree")]
    }()

    private func newOnboardVC(page: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(page)VC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        // Set the first onboard page
        if let firstPageVC = onboardVCArray.first {
            setViewControllers([firstPageVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = onboardVCArray.count
        
        // The dot state will not change with current page index change
        // See the delagate function for changing the dot state
        pageControl.currentPage = 0
        
        // Scale up the size of the dots
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(pageControl)
    }
}

extension OnboardPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = onboardVCArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // Loop when user swipe left at the first VC to see the last VC
        guard previousIndex >= 0 else {
            return onboardVCArray.last
            // If you don't want loop, return nil
            // return nil
        }
        
        guard onboardVCArray.count > previousIndex else {
            return nil
        }
        
        return onboardVCArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = onboardVCArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = onboardVCArray.count
        
        // Loop when user swipe right at the last VC to see the first VC
        guard orderedViewControllersCount != nextIndex else {
            return onboardVCArray.first
            // If you don't want loop, return nil
            // return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return onboardVCArray[nextIndex]
    }
    
    // To trash page curl and replace it with a horizontal scroll, go to Mainstoryboard
    // and to attributes inspector, change transition style to scroll

    // Delegate page indicator, current dot state now change with current page index
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentPageVC = pageViewController.viewControllers![0]
        self.pageControl.currentPage = onboardVCArray.index(of: currentPageVC)!
    }
}






