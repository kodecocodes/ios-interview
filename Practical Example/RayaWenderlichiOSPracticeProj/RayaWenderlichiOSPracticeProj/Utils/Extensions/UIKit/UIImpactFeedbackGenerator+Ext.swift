import UIKit

protocol ImpactFeedBackGenerator {
    static func generate(style: UIImpactFeedbackGenerator.FeedbackStyle)
}

extension UIImpactFeedbackGenerator: ImpactFeedBackGenerator {
    static func generate(style: FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
