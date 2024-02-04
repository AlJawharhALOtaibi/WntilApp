//
//  GifImage.swift
//  Wntil
//
//  Created by Wajd Alhadlaq on 22/07/1445 AH.
//


import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
private let name : String

init(name: String) {
self.name = name
}

func makeUIView(context: Context) -> WKWebView {
let webView = WKWebView()
let url = Bundle.main.url(forResource: name, withExtension: "gif")!
let data = try! Data(contentsOf: url)

webView.load(
data,
mimeType: "image/gif",
characterEncodingName: "UTF-8",
baseURL: url.deletingLastPathComponent()
)

return webView
}

func updateUIView(_ uiView: WKWebView, context: Context) {
uiView.reload()
}

typealias UIViewType = WKWebView
}

struct GifImage_Previews: PreviewProvider {
static var previews: some View {
GifImage(name: "Fairy")
}
}
