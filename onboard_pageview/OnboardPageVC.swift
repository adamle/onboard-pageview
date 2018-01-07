//
//  OnboardPageVC.swift
//  onboard_pageview
//
//  Created by Le Dang Dai Duong on 06/01/2018.
//  Copyright © 2018 Le Dang Dai Duong. All rights reserved.
//

import UIKit

class OnboardPageVC: UIPageViewController {

    private func newOnboardVC(page: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(page)VC")
    }
    
    private(set) lazy var onboardVCArray: [UIViewController] = {
        return [self.newOnboardVC(page: "PageOne"),
                self.newOnboardVC(page: "PageTwo"),
                self.newOnboardVC(page: "PageThree")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstPageVC = onboardVCArray.first {
            setViewControllers([firstPageVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

extension OnboardPageVC: UIPageViewControllerDataSource {
    
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

    // Implement the pagination dots (page indicator) - default state
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return onboardVCArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = onboardVCArray.index(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
    
}






