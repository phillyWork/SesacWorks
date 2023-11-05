//
//  OnBoardingViewController.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/25.
//

import UIKit

class OnBoardingViewController: UIPageViewController {

    let vcList: [UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let firstVC = sb.instantiateViewController(withIdentifier: FirstViewController.identifier) as! FirstViewController
        let secondVC = sb.instantiateViewController(withIdentifier: SecondViewController.identifier) as! SecondViewController
        let thirdVC = sb.instantiateViewController(withIdentifier: ThirdViewController.identifier) as! ThirdViewController

        return [firstVC, secondVC, thirdVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        configVC()
    }
    
    func configVC() {
        delegate = self
        dataSource = self
        //transition: Storyboard에서 설정
        
        guard let first = vcList.first else { return }
        
        setViewControllers([first], direction: .forward, animated: true)
    }
    

}

//MARK: - Extension for Page Delegate, Datasource

extension OnBoardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = vcList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : vcList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = vcList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        return nextIndex >= vcList.count ? nil : vcList[nextIndex]
        
    }
    
    
    //page control
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let index = vcList.firstIndex(of: firstVC) else { return 0 }
        return index
    }
    
    
}
