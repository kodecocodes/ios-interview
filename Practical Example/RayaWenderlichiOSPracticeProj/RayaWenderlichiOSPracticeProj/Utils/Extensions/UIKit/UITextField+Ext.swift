import UIKit

extension UITextField {
    // MARK: - Public Properties

    // https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
