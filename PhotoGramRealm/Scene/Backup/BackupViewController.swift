//
//  BackupViewController.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/07.
//

import UIKit
import SnapKit
import Zip

class BackupViewController: BaseViewController {

    lazy var backupButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        return button
    }()

    lazy var restoreButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        return button
    }()

    let backupTableView = {
        let table = UITableView()
        table.rowHeight = 50
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backupTableView.delegate = self
        backupTableView.dataSource = self
    }
    
    
    override func configure() {
        super.configure()
        
        view.backgroundColor = .white
        
        view.addSubview(backupTableView)
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    //MARK: - Handlers
    
    @objc func backupButtonTapped() {
        //1. 압축하고 싶은 파일 경로 url 담을 배열
        var urlPaths = [URL]()
        
        //Documents 폴더 경로: FileManager Extension
        //2. 경로 존재하는지 확인
        guard let path = documentDirectoryPath() else {
            //경로 존재하지 않음을 유저에게 알려야 함
            print("Documents 위치에 오류 있음")
            return
        }
        
        //3. 백업하고자 하는 파일 경로
        //e.g. ~~~/~~/~~~/Documents/default.realm
        let realmFile = path.appendingPathComponent("default.realm")

        //백업할 항목에 사진 필요: 사진도 url에 추가해야 함
        //모든 사진 하나씩 설정: 모든 경로 다 가지고 와야함
        //폴더 내에 사진 저장, 일괄적 가져오기
        
        //폴더 만드는 법?
        
        
        
        //4. 해당 경로가 유효한 경로인지 (파일 실제 존재하는지) 확인
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            //유효한 파일 없음을 유저에게 알려야 함
            print("백업할 파일이 없습니다")
            return
        }
        
        //5. 압축하고자 하는 파일을 배열에 추가
        urlPaths.append(realmFile)
        
        
        //6. 배열을 압축: open source 활용
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "JackArchive_\(Date())")
            print("location: \(zipFilePath)")
            self.backupTableView.reloadData()
        } catch {
            print("압축 실패")
        }
        
        //7. 백업 파일 목록 보여주기 --> tableView cell 설정
    }
    
    
    @objc func restoreButtonTapped() {
        
        //File앱에서 백업 파일 확인
        //파일 형식 지정 가능 (모든 data에 접근하지 못하도록)
        //asCopy: data 원본 놔두고 복사해올 것인지
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        
        //여러개 선택 방지
        documentPicker.allowsMultipleSelection = false
        
        present(documentPicker, animated: true)
    }

}

//MARK: - Extension for DocumentPicker Delegate

extension BackupViewController: UIDocumentPickerDelegate {
    
    //취소 버튼
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
    
    //선택 버튼: multiple selection 허용 시 여러 url 전달
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        //선택한 파일 압축해제해서 realm 가져오기
        //multiple selection 방지 --> first로 가져와도 무방
        guard let selectedFileURL = urls.first else {       //File App에서의 URL 주소
            print("선택한 파일 오류 발생")
            return
        }
        
        guard let path = documentDirectoryPath() else {     //Documents 폴더 위치
            print("Documents 위치 오류")
            return
        }
        
        //선택한 파일을 Documents로 이동, 압축 해제하기
        
        //Documents 폴더 내 저장할 경로 설정
        //실제 zip 파일 이름만, 앞의 FileApp 경로 제외하고 Documents에 추가하기
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        print("sandboxFileURL lastComponent: \(sandboxFileURL.lastPathComponent)")
        
        
        //압축 해제 진행
        
        //같은 파일 반복 선택 ~ Documents 내 경로에 복구할 파일 이미 있는지 확인
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            //복구할 파일 이미 존재 (이전에 선택한 경우)
            //기존 압축 파일로 진행
            
            //FIleApp 내에서 JackArchive_130.zip이라고 해도
            //Documents 안에서는 JackArchive.zip으로 저장됨
            
            //흐름따라 잘 설정해야 함
            let fileURL = path.appendingPathComponent(sandboxFileURL.lastPathComponent)
            do {
                //Documents에서 바로 해제하기
                //overwrite: 앱 실행 상태의 default.realm을 백업한 default.realm으로 덮어쓰기
                //progress: 진행 상황 관련 closure 처리
                //fileOutputHandler: 압축 해제 완료 관련 closure 처리
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("압축 해제 완료: \(unzippedFile)")
                    
                    //unzip 성공 후 zip 제거하기
                    //사진 제거와 동일
                    
                })
                
                //강제 종료
                exit(0)
                
            } catch {
                print("압축 해제 실패")
            }

            //or 덮어쓰기
            
            
        } else {
            //복구할 파일 없을 경우
            //fileApp에 있는 파일을 복사, 붙여넣기
            do {
                //어디에 있는 파일을 어디로 복사할지
                //FileApp의 파일을 Documents 폴더 내로
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent(sandboxFileURL.lastPathComponent)
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("압축 해제 완료: \(unzippedFile)")
                })
                
                //강제 종료
                exit(0)
                
            } catch {
                print("압축 해제 실패")
            }
            
            
        }
                
    }
    
}


//MARK: - Extension for TableView Delegate, DataSource

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    
    //archive 파일
    func fetchZipList() -> [String] {
        var list: [String] = []
        
        do {
            //Documents 경로 접근
            guard let path = documentDirectoryPath() else { return list }
            //Documents 내 모든 파일 가지고 옴
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            //그 중 확장자 zip인 파일만
            //.zip : 컴퓨터가 ..zip으로 판단
            let zip = docs.filter { $0.pathExtension == "zip" }
            
            //앞의 전체 path 말고 마지막 / 기준 뒤의 path 나타내기
            //Documents 내 파일 이름만 나타내기
            for i in zip {
                list.append(i.lastPathComponent)
            }
        } catch {
            print("Error")
        }
        
        return list
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //최종 가지고 온 .zip 파일 목록 개수
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = backupTableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = fetchZipList()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell 선택 시, ActivityViewController 띄우기
        //해당 cell의 파일 이름 전달 (fetchZipList에서 파일 이름 보유)
        showActivityViewController(fileName: fetchZipList()[indexPath.row])
    }
    
    
    func showActivityViewController(fileName: String) {
        //Documents 경로 확인
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있어요")
            return
        }
        
        //고정된 파일 전달
//        let backupFileURL = path.appendingPathComponent("JackArchive.zip")

        //indexPath에 해당하는 파일 전달
        let backupFileURL = path.appendingPathComponent(fileName)
        
        //activityItems: data
        //file url 전달하기
        
        //applicationActivities: 관련 action

        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        
        present(vc, animated: true)
    }
    
}
