//
//  BaseViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

//constraints 설정용 모든 VC에서 활용: BaseVC가 import
//자식 class들은 작성 필요 없음
import SnapKit


//UIVC 상속, VC에서 공통적으로 나타나는 요소들 작성
//나머지 VC: BaseVC를 상속해서 바로 가져다 쓰기
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        setConstraints()
    }
    
    func configViews() {
        view.backgroundColor = .white
        print("Base ConfigViews")
    }
    
    func setConstraints() {
        print("Base setConstraints")
        
    }

   
}
