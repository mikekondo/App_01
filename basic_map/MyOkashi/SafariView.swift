//
//  SafariView.swift
//  MyOkashi
//
//  Created by admin on 2021/04/20.
//

import SwiftUI
//SafariServicesというフレームワークはアプリから外部のSafariを起動させるのではなく、アプリの内部でSafafiを起動することができ、ウェブビューと言われている
import SafariServices

//SFSafariViewControllerはSwiftUIではまだ提供されてないので、UIViewControllerRepresentableプロトコルに準拠して、SwiftUIでも扱えるようにラップしている
//SFSafariViewControllerを起動する構造体
struct SafariView:UIViewControllerRepresentable{
    //表示するホームページのURLを受ける変数
    var url:URL
    //表示するViewを生成するときに実行
    //UIViewControllerRepresentableに準拠しているViewでは、Viewを生成するタイミングで、自動的にmakeUIViewControllerメソッドを呼び出す
    func makeUIViewController(context: Context) -> SFSafariViewController {
        //Safariを起動
        return SFSafariViewController(url: url)
    }
    //Viewが更新された時に実行
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        //処置なし
    }
}
