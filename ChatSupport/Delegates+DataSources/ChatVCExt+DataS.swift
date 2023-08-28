//
//  ChatVCExt+DataS.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit

class ChatDataDataSource: NSObject, UITableViewDataSource, UITextViewDelegate {
    
    private let viewModel: ChatVM!
    
    init(viewModel: ChatVM) { self.viewModel = viewModel }
    
    //MARK:- UITableView DataSource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = viewModel.arrMessages[indexPath.row]
        if detail.isSender {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SenderTextTVC
            cell.lblText.text = detail.textMessage
            DispatchQueue.main.async {
                cell.vwBackground.customCorner([.topRight,.topLeft,.bottomLeft], radius: 25)
            }
            return cell
        } else {
            if viewModel.isTextBasedChat {
                let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ReceiverTextTVC
                cell.txtVwMessage.delegate = self
                if detail.textMessage == "" {
                    cell.txtVwMessage.text = "mgfjksfgkd"
                    cell.txtVwMessage.isHidden = true
                    cell.imgVwTyping.isHidden = false
                    let image = UIImage.gif(name: "typing-dot")
                    DispatchQueue.main.async {
                        cell.imgVwTyping.image = image
                    }
                } else {
                    cell.txtVwMessage.isHidden = false
                    cell.txtVwMessage.text = detail.textMessage
                    cell.imgVwTyping.isHidden = true
                }
                cell.cnstHeightTxtVwMessage.constant = cell.txtVwMessage.contentSize.height + 10
                DispatchQueue.main.async {
                    cell.vwBackground.customCorner([.topRight,.topLeft,.bottomLeft], radius: 25)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ReceiverImageTVC
                if detail.textMessage == "" {
                    cell.imgVwTyping.isHidden = false
                    cell.imgVwMessage.isHidden = true
                    let image = UIImage.gif(name: "typing-dot")
                    DispatchQueue.main.async {
                        cell.imgVwTyping.image = image
                    }
                } else {
                    cell.imgVwMessage.isHidden = false
                    cell.imgVwTyping.isHidden = true
                    cell.imgVwMessage.setImageOnImageView(detail.textMessage)
                }
                return cell
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
    }
    
}

class ChatDataDelegates: NSObject, UITableViewDelegate {
    
    private let objViewModel: ChatVM!
    
    init(viewModel: ChatVM) { objViewModel = viewModel }
    
    // MARK: UITableView Delegate Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
}
extension UIImage {
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }
        return UIImage.animatedImageWithSource(source)
    }
    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        return gif(data: imageData)
    }
    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        return gif(data: imageData)
    }
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }
        let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        delay = delayObject as? Double ?? 0
        if delay < 0.1 {
            delay = 0.1 // Make sure they're not too fast
        }
        return delay
    }
    internal class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        // Check if one of them is nil
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        // Swap for modulo
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = a! % b!
            if rest == 0 {
                return b! // Found it
            } else {
                a = b
                b = rest
            }
        }
    }
    internal class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        var gcd = array[0]
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        return gcd
    }
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            for val: Int in delays {
                sum += val
            }
            return sum
        }()
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        return animation
    }
}
