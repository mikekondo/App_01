//
//  OkashiData.swift
//  MyOkashi
//
//  Created by admin on 2021/04/18.
//

import Foundation
import UIKit
//identifiable=識別可能
//Identifiableプロトコルを利用して、お菓子の情報をまとめる構造体
//Identifiableを指定すると、データを一意に特定するために「id」と呼ばれるプロパティを定義する必要がある
//UUIDを用いて、ランダムな一意の値を生成することができる
struct OkashiItem: Identifiable{
    let id=UUID()
    let name:String
    let link:URL
    let image: UIImage
}
//ObservableObjectプロトコルに準拠するクラスをOkashiDataとして定義
//structでは、ObsevableObjectプロトコルを利用することができない
//ObservableObjectはカスタムクラス内でデータの状態を管理するために利用する
class OkashiData: ObservableObject {
    //JSONのデータ構造
    //Codableプロトコルに準拠することで、JSONのデータ項目名とプログラムの変数名を同じ名前にすると、JSONを変換した時に、一括して変数にデータをまとめることができる
    //Codableプロトコルを使用して、JSONをSwiftオブジェクトにエンコードしたり、デコードしたりすることができる
    struct ResultJson: Codable{
        //JSONのitem内のデータ構造
        struct Item:Codable{
            //お菓子の名称
            let name: String?
            //掲載URL
            let url:URL?
            //画像URL
            let image:URL?
        }
        let item:[Item]?//定義した構造体Itemを、[]で囲むことで複数の構造体を保持できる配列として宣言している。
        
    }
    //お菓子のリスト(Identifiableプロトコル)
    //Publishedを付与することで、プロパティを監視して自動通知をすることができる
    @Published var okashiList: [OkashiItem]=[]
    //Web API検索用メソッド　第一引数：keyword 検索したいワード
    func searchOkashi(keyword: String){
        //デバッグエリアに出力
        print(keyword)
        //お菓子の検索キーワードをURLエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        // リクエストURLの組み立て
        // URLの文字列の中にエンコード済みのキーワードを埋め込んでいる
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print(req_url)
        
        // リクエストに必要な情報を生成
        // リクエストURLから、リクエストを管理するためのオブジェクトを生成している
        let req = URLRequest(url: req_url)
        // データ転送を管理するためのセッションを生成(一旦引数は気にしないで進める)
        // OperationQueueを用いることで、非同期処理を行うことができる(非同期処理とは、処理の実行中に別の処理を止めないことを言う)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // dataTaskメソッドでリクエストをタスクとして登録、第二引数がクロージャになっていてダウンロードが完了すると下記が実行される
        let task = session.dataTask(with: req, completionHandler: {
            (data, response ,error) in
            // データ取得が完了したタイミングで、セッションを終了
            session.finishTasksAndInvalidate()
            // do try catch エラーハンドリング
            do {
                // JSONDecoderのインスタンス取得
                let decoder = JSONDecoder()
                // 受け取ったJSONデータをパース（解析）して格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                //print(json)
                if let items=json.item{
                    //お菓子のリストを初期化
                    self.okashiList.removeAll()
                    //取得しているお菓子の数だけ処理
                    for item in items{
                        //お菓子の名称、掲載URL、画像URLをアンラップ
                        if let name=item.name ,
                           let link = item.url ,
                           let imageUrl=item.image ,
                           let imageData=try? Data(contentsOf: imageUrl),
                           let image = UIImage(data:imageData)?.withRenderingMode(.alwaysOriginal){
                            //一つのお菓子を構造体でまとめて管理
                            let okashi=OkashiItem(name: name,link:link,image:image)
                            //お菓子の配列の追加
                            self.okashiList.append(okashi)
                        }
                    }
                    print(self.okashiList)
                }
            } catch {
                // エラー処理
                 print("エラーが出ました")
            }
        })
        //task.resume()で、dataTaskメソッドで登録されたリクエストのタスクが実行され、JSONのダウンロードが始まる
        task.resume()
        
    }
}
