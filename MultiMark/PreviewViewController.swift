//
//  PreviewViewController.swift
//  MultiMark
//
//  Created by Michael Redig on 4/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit
import Down
import WebKit
import Html

class PreviewViewController: UIViewController, WKNavigationDelegate {

	@IBOutlet var outputView: WKWebView!
	
	var fontSize = 100
	
	let css: String
	
	var text: String = "" {
		didSet {
			let down = Down(markdownString: text)
//			let style = "body { font: 200% sans-serif; }"
			let markdownHtml = (try? down.toHTML()) ?? ""
			let doc: Node = .document(
				.html(
					.head(
						.style(unsafe: css)
					),
					.body(
						.raw(markdownHtml)
					)
				)
			)
			outputView.loadHTMLString(render(doc), baseURL: nil)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		let cssUrl = Bundle.main.url(forResource: "modern", withExtension: "css")!
		css = try! String(contentsOf: cssUrl, encoding: .utf8)
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		configureSizeButtons()
		outputView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
	
	func configureSizeButtons() {
		navigationItem.rightBarButtonItems = [
			UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(adjustSizeUp)),
			UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(adjustSizeDown))
		]
	}
	
	@objc func adjustSizeUp() {
		fontSize += 50
		adjustSize()
	}
	
	@objc func adjustSizeDown() {
		fontSize -= 50
		adjustSize()
	}
	
	func adjustSize() {
		let js = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='\(fontSize)%'"
		outputView.evaluateJavaScript(js, completionHandler: nil)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		adjustSize()
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
