//
//  ViewController.swift
//  AppStore
//
//  Created by SecurityIBK on 2018. 4. 8..
//  Copyright © 2018년 HoSeong Choi. All rights reserved.
//

import UIKit

class AppListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var entryTableView: UITableView!
    
    let LIST_URL = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
    var appList:Array<FreeFinanceApp>? = []
    var rowCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        entryTableView.delegate = self
        entryTableView.dataSource = self
        self.getAppList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAppList(){
        
        let url = URL(string:LIST_URL)
        
        if url != nil {
            var request = URLRequest(url: url!)
            request.httpMethod = "get"
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: {(data: Data?, response:URLResponse?, error:Error?) in
                guard error == nil && data != nil else{
                    if let err = error {
                        //어떤 error가 올 수 있는지 확인하고 이에 따라 대응 필요
                        print(err.localizedDescription)
                    }
                    return
                }
                
                if let _data = data{
                    do{
                        let jsonAppList = try JSONSerialization.jsonObject(with: _data, options: .mutableContainers) as! [String:Any]
                        let util:DataUtil = DataUtil()
                        self.appList = util.parseRawData(rawData: jsonAppList)
                        
                        //MainThread 변경을 위해 사용
                        DispatchQueue.main.sync {
                            if let count = self.appList?.count{
                                for index in 0...count-1{
                                    self.rowCount += 1
                                    let indexPath = IndexPath(row: index, section:0)
                                    self.entryTableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                                }
                            }
                        }
                    }catch{
                        
                    }
                }else{
                    //data가 nil일 경우에 대한 처리가 필요해 보인다
                    self.showAlert(strMessage: "수신된 정보가 없습니다.")
                }
            })

            task.resume()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("IndexPath \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Application", for: indexPath) as! AppTableCell
        if let arrValue = self.appList?[indexPath.row] {
            
            //앱 이미지 설정
            if let arrImage = arrValue.imImage{
                for indexImage in arrImage{
                    if let imageInfo = indexImage as? [String:Any]{
                        let attribute = imageInfo["attributes"] as! [String:Any]
                        let height = attribute["height"] as! String
                        let label = imageInfo["label"] as! String
                        
                        if let imageData = arrValue.imageDic[height]{
                            //저장되어 있던 이미지 설정
                            if height == "75"{
                                cell.appImage.image = UIImage(data: imageData)
                            }
                        }else{
                            //height의 값을 가지는 이미지가 imageDic에 없으면 다운로드
                            DispatchQueue(label: "imageDownload").async {
                                if let url = URL(string: label){
                                    if let imageData = try? Data(contentsOf: url){
                                        arrValue.imageDic[height] = imageData
                                        if height == "75"{
                                            DispatchQueue.main.async {
                                                cell.appImage.image = UIImage(data: imageData)
                                            }
                                        }
                                    }else{
                                         print("이미지 다운로드 실패")
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            
            cell.appRanking.text = String(indexPath.row + 1)
            
            //앱 이름 설정
            if let imName = arrValue.imName{
                cell.appName.text =  imName["label"] as? String
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedApp = self.appList?[indexPath.row]{
            self.performSegue(withIdentifier:"AppDetailSegue", sender:selectedApp)
        }else{
            self.showAlert(strMessage: "앱 정보가 없습니다.")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AppDetailSegue"{
            if let appDetail = segue.destination as? AppDetailViewController{
                appDetail.appInfo = sender as? FreeFinanceApp
            }
        }else{
           self.showAlert(strMessage: "화면전환에 실패하였습니다")
        }
    }
    
    @IBAction func moveAppList(sender: UIStoryboardSegue){
        print("moveAppList")
    }
    
    func showAlert(strMessage: String){

        let alertController = UIAlertController(title: "알림",message: strMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
            
        }
        
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
}

