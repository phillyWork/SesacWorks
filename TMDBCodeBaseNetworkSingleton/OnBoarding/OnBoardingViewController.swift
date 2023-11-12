//
//  OnBoardingViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class OnBoardingViewController: UIPageViewController {
    
    let vcList: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    //직접 horizontal, scroll transition --> 직접 pageviewcontroller와 pagecontrol 만들고 currentIndicatorIndex 구하기 등 설정 필요
    //다른거 하고 해보기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        guard let first = vcList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

//MARK: - Extension for UIPageViewDelegate, DataSource

extension OnBoardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = vcList.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : vcList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = vcList.firstIndex(of: viewController) else { return nil }
        let afterIndex = currentIndex + 1
        
        return afterIndex >= vcList.count ? nil : vcList[afterIndex]
    }
    
    //pageControl
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = vcList.first, let firstIndex = vcList.firstIndex(of: firstVC) else { return 0 }
        return firstIndex
    }
    
    
    
    
}
