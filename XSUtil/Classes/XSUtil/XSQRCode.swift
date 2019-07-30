//
//  XSQRCode.swift
//  Pods-XSUtil_Example
//
//  Created by 123 on 2019/6/12.
//

/// 二维码图片生成
///
/// - Parameters:
///   - text: 二维码字符串
///   - iconImage: 头像图片, 默认为空
/// - Returns: 二维码图片
public func setupQRCodeImage(with text: String,
                      iconImage: UIImage? = nil) -> UIImage {
    //  1. 创建滤镜
    let filter = CIFilter(name: "CIQRCodeGenerator")
    filter?.setDefaults()
    
    //  2. 将字符串添加到二维码滤镜中
    filter?.setValue(text.data(using: .utf8), forKey: "inputMessage")
    
    //  3. 取出生成的二维码
    guard let outputImage = filter?.outputImage else { return UIImage() }
    
    //  4. 生成清晰度更高的二维码图片
    var qrCodeImage = setupHighDefinitionImage(outputImage, size: 300)
    
    //  5. 如果中心区域有图片，合成新二维码图片
    if iconImage != nil {
        //给头像加一个白色圆边（如果没有这个需求直接忽略）
        let image = circleImageWithImage(iconImage!, borderWidth: 2, borderColor: UIColor.white)
        qrCodeImage = syntheticImage(qrCodeImage, iconImage: image)
    }
    
    //  6. 返回二维码图片
    return qrCodeImage
}

/// 图片合成
///
/// - Parameters:
///   - image: 二维码
///   - iconImage: 头像图片
///   - width: 头像的宽
///   - height: 头像的高
/// - Returns: 带头像的二维码图片
func syntheticImage(_ qrCodeImage: UIImage,
                    iconImage:UIImage) -> UIImage {
    
    //  1. 开启图片上下文
    UIGraphicsBeginImageContext(qrCodeImage.size)
    //  2. 绘制二维码图片
    qrCodeImage.draw(in: CGRect(origin: CGPoint.zero, size: qrCodeImage.size))
    //  3. 绘制头像
    let x = (qrCodeImage.size.width - 80) / 2
    let y = (qrCodeImage.size.height - 80) / 2
    iconImage.draw(in: CGRect(x: x, y: y, width: 80, height: 80))
    //  4. 取出图片
    let syntheticImage = UIGraphicsGetImageFromCurrentImageContext()
    //  5. 关闭上下文
    UIGraphicsEndImageContext()
    //  6. 返回图片
    return syntheticImage ?? UIImage()
}

/// 生成高清图片
///
/// - Parameters:
///   - image: 图片
///   - size: 图片大小
/// - Returns: 高清图片
func setupHighDefinitionImage(_ image: CIImage,
                                size: CGFloat) -> UIImage {
    let integral: CGRect = image.extent.integral
    let proportion: CGFloat = min(size/integral.width, size/integral.height)
    
    let width = integral.width * proportion
    let height = integral.height * proportion
    let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
    let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
    
    let context = CIContext(options: nil)
    let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
    
    bitmapRef.interpolationQuality = CGInterpolationQuality.none
    bitmapRef.scaleBy(x: proportion, y: proportion);
    bitmapRef.draw(bitmapImage, in: integral);
    let image: CGImage = bitmapRef.makeImage()!
    return UIImage(cgImage: image)
}

/// 生成边框图片
///
/// - Parameters:
///   - sourceImage: 图片
///   - borderWidth: 边框宽度
///   - borderColor: 边框颜色
/// - Returns: 带边框图片
func circleImageWithImage(_ sourceImage: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
    let imageWidth = sourceImage.size.width + 2 * borderWidth
    let imageHeight = sourceImage.size.height + 2 * borderWidth
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
    UIGraphicsGetCurrentContext()
    
    let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width:sourceImage.size.height) * 0.5
    let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
    bezierPath.lineWidth = borderWidth
    borderColor.setStroke()
    bezierPath.stroke()
    bezierPath.addClip()
    sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

