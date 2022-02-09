//
//  ViewController.swift
//  wishlist
//
//  Created by Keyaki Sato on 2022/01/14.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //UI関係
    //一時的
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var testButton: UIButton!
    
    //画面遷移ボタン
    @IBOutlet weak var SwitchButton: UIButton!
    
    //真ん中の詳細表示欄
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var BuyButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    
    //上部の記入欄
    @IBOutlet weak var EnterButton: UIButton!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PriceField: UITextField!
    
    //DB表示欄
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()

    //その他変数
    var selecter = 0
    
    //-----------------------画面2へ

    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        NameLabel.text = "商品名"
        PriceLabel.text = "価格"
        TimeLabel.text = "経過時間"
        BuyButton.setTitle("買う", for: .normal)
        CancelButton.setTitle("やめる", for: .normal)
        BuyButton.isEnabled = false
        CancelButton.isEnabled = false
        
        SwitchButton.setTitle("履歴", for: .normal)


        NameField.placeholder = "商品の名前"
        PriceField.placeholder = "商品の価格"
        PriceField.keyboardType = UIKeyboardType.numberPad
        
        EnterButton.setTitle("登録", for: .normal)
        deleteButton.setTitle("初期化", for: .normal)
        testButton.setTitle("更新", for: .normal)
        
        
        let wishData = realm.objects(nWishList.self)
        print("🟥全てのデータ\(wishData)")
        
        
        //-----------------------画面2へ
       
        
        
        
    }
    
    

    //EnterButton
    @IBAction func ButtonAction(_ sender: Any) {

        let wish = nWishList()
        wish.name = NameField.text!
        wish.price = PriceField.text!
        wish.date = Date()

        
        
        try! realm.write {
            realm.add(wish)
        }
        NameField.text = ""
        PriceField.text = ""
        tableView.reloadData()
        
        //キーボードを閉じる
        NameField.endEditing(true)
        PriceField.endEditing(true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let  wishData = realm.objects(nWishList.self)
            return wishData.count
    }
    
    
    
    //TableにDB情報を表示する関数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let wishData = realm.objects(nWishList.self)
            cell.textLabel!.text = "\(wishData[indexPath.row].name)"
            cell.detailTextLabel!.text = String("\(wishData[indexPath.row].price)円")
            //cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

            return cell
    }

    
    //cell選択時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wishData = realm.objects(nWishList.self)
        var elapsedTime :Double = 0
        print("\(wishData[indexPath.row])")
        
        NameLabel.text = "\(wishData[indexPath.row].name)"
        PriceLabel.text = "\(wishData[indexPath.row].price)円"
        
        CancelButton.isEnabled = true
        
        selecter = indexPath.row
        print(selecter)
        
        
        elapsedTime = calcTime(regD: wishData[selecter].date)
        TimeLabel.text = String(format: "%.2f", elapsedTime) + "時間経過"
        
        if (elapsedTime>=72.0){
            BuyButton.isEnabled = true
            TimeLabel.text = "72時間経過"
        }
        
        
        
        
        
        
        //キーボードを閉じる
        NameField.endEditing(true)
        PriceField.endEditing(true)
        
        
        //動作テストゾーン

        
        
        
    }
        
        
    

    //初期化ボタン
    @IBAction func deleteButtonAction(_ sender: Any) {
        try! realm.write{
            realm.deleteAll()
        }
        NameField.text = ""
        PriceField.text = ""
        tableView.reloadData()
    }
    
    
    
    
    //確認ボタン
    @IBAction func testButtonAction(_ sender: Any) {
        
        
        let wishData = realm.objects(nWishList.self)
        print("🟥全てのデータ\(wishData)")
        
        //print(type(of: wishData[selecter].name))

    }
    
    
    @IBAction func BuyButtonAction(_ sender: Any) {
        print("買う")
    }
    
    @IBAction func CancelButtonAction(_ sender: Any) {
        print(selecter)
        print("キャンセル")
        
        let wishData = realm.objects(nWishList.self)
        try! realm.write {
                        let item = wishData[selecter]
                        realm.delete(item)
                    }
        
        //Table表示データの更新
        tableView?.reloadData()
        
        //詳細表示欄の初期化
        NameLabel.text = "商品名"
        PriceLabel.text = "価格"
        TimeLabel.text = "経過時間"
        BuyButton.isEnabled = false
        CancelButton.isEnabled = false
        
    }
    
    //経過時間を計算する関数
    func calcTime(regD: Date) -> Double{
        var result: Double = 0
        result = Double(Date().timeIntervalSince(regD))
        result /= 3600
        print(result)
        
        return result
        
    }
    

    
    
    
    
}

