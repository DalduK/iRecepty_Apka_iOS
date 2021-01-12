//
//  QRCodeGenerator.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 12/01/2021.
//
import CoreImage.CIFilterBuiltins
import UIKit

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()
func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")
    if let outputImage = filter.outputImage{
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            return UIImage(cgImage: cgimg)
            
        }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
}

