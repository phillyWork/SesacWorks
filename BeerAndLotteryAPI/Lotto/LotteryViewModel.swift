//
//  LotteryViewModel.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/09/13.
//

import Foundation

enum BlankSpace: String {
    case placeholder = "회차를 선택해주세요"
    case blank = ""
}

class LotteryViewModel {
    
    private let lottoDrawingNumbers: [Int] = Array(1...1100).reversed()
    
    var lottoDrawing: Observable<String> = Observable("1")
    var lottoResult: Observable<Lotto?> = Observable(nil)
    
    var resultText: Observable<String> = Observable("로또 결과는?")
    
    private let networkManager = NetworkManager.shared
    
    func callReqeust(number: String) {
        //String --> Int로 형변환
        guard let number = Int(number) else {
            //형변환 실패: 네트워크 할 수 없음 알리기
            resultText.value = "숫자로 전환할 수 없는 문자이므로 로또 검색을 할 수 없습니다."
            return
        }
        
        networkManager.searchUrl(number: number) { result in
            switch result {
            case .success(let success):
                //해당 결과를 lottoResult의 값으로 update하기
                //lottoResult의 bind로 정의된 listener 실행하기
                self.lottoResult.value = success
                self.resultText.value = "로또 번호는 다음과 같습니다."
            case .failure(let failure):
                self.resultText.value = "네트워크 통신에 실패했습니다."
            }
        }
    }
    
    func numberOfRowsInComponent() -> Int {
        return lottoDrawingNumbers.count
    }
        
    //pass to lottoDrawing: update value
    func convertToStringForLottoDrawing(row: Int) {
        lottoDrawing.value = String(row)
    }
    
    func pickerTitle(row: Int) -> String {
        return String(lottoDrawingNumbers[row])
    }

    
}
