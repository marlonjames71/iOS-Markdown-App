//
//  PreviewViewController.swift
//  MultiMark
//
//  Created by Michael Redig on 4/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit
import Down

class PreviewViewController: UIViewController {

	@IBOutlet var outputView: UITextView!
	
	var text: String = "" {
		didSet {
			let down = Down(markdownString: text)
			let style = "body { font: 200% sans-serif; }"
			let attributedString = try? down.toAttributedString(stylesheet: style)
			outputView.attributedText = attributedString
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
