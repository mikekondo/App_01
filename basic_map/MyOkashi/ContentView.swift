//
//  ContentView.swift
//  MyOkashi
//
//  Created by admin on 2021/04/18.
//

import SwiftUI

struct ContentView: View {
    //先ほど作成したOkashiDataクラスのインスタンスを生成
    @ObservedObject var OkashiDataList=OkashiData()
    //TextFieldに入力された文字列を保持する状態変数
    @State var inputText = ""
    //SafariViewの表示有無を管理する変数
    @State var showSafari=false
    var body: some View {
        //垂直にレイアウト(縦方向にレイアウト)
        VStack{
            //文字を受け取るTextFieldを表示する
            TextField("キーワードを入力してください",text: $inputText,onCommit:{
                //入力完了直後に検索する
                OkashiDataList.searchOkashi(keyword: inputText)
            })
            //上下左右に余白を空ける
            .padding()
            //リスト表示する
            List(OkashiDataList.okashiList){okashi in
                //一つ一つの要素が取り出される
                //ボタンを用意する
                //Buttonのactionに、Safariの表示、非表示を管理する変数showSafariのtoggleメソッドを利用して切り替えている
                //toggleメソッドを実行するたびにshowSafariのfalseがtrueに切り替わる
                Button(action:{
                    //SafariViewを表示する
                    showSafari.toggle()
                }){
                    //okashiに要素を取り出して、List(一覧)を生成する
                    //水平にレイアウト(横方向にレイアウト)
                    HStack{
                        //画像を表示する
                        Image(uiImage: okashi.image)
                            //リサイズする
                            .resizable()
                            //アスペクト比(縦横比)を維持してエリア内に収まるようにする
                            .aspectRatio(contentMode: .fit)
                            //高さ40
                            .frame(height: 40)
                        //テキストを表示する
                        Text(okashi.name)
                    }
                }// Buttonここまで
                .sheet(isPresented: self.$showSafari,content:{
                    //SafariViewを表示する
                    SafariView(url: okashi.link)
                    //画面下部をいっぱいになるようにセーフエリア外までいっぱいになるように指定
                        .edgesIgnoringSafeArea(.bottom)
                })
            }//Listここまで
        }//VStackここまで
    }//bodyここまで
}//ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
