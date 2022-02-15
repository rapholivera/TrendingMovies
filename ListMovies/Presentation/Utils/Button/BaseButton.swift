//
//  BaseButton.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class BaseButton: UIButton {

    // MARK: - Init

    override var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.35
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)

        setupUI()

        addTarget(self, action: #selector(animatePressDown), for: .touchDown)
        addTarget(self, action: #selector(animatePressUp), for: .touchDragExit)
        addTarget(self, action: #selector(animatePressDown), for: .touchDragEnter)
        addTarget(self, action: #selector(animatePressUp), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    // MARK: - Helper Functions

    @objc fileprivate func animatePressDown() {
        UIButton.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
            self.alpha = 0.5
        })
    }

    @objc fileprivate func animatePressUp() {
        UIButton.animate(withDuration: 0.1, animations: {
            self.transform = .identity
            self.alpha = 1.0
        })
    }

    // MARK: - UI Setup

    private func setupUI() {
        layer.cornerRadius = frame.size.height / 4
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .title2)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
