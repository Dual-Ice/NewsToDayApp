//
//  TabBarPresenter.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//
import Foundation

protocol CustomTabBarViewProtocol: AnyObject {
    
    func showTabBar(_ show: Bool, animated: Bool, over duration: TimeInterval)
    
    func disableTransparentTabBar()
    
    func setupTabBarTags()
    
    func setupCurve(_ radius: Float)
    
    func setupCircle(_ width: Float)
    
    func updateCircleSize(_ radius: Float)
    
    func setupTabBarColoring()
    
    func setupTabBarBackground()
    
    func setupImageView(_ center: Float)
    
    func updateImageViewSize(_ center: Float)
    
    func updateImageView()
    
    func moveCurve(with duration: TimeInterval, to index: Int, with radius: Float)
    
    func moveCircle(over duration: TimeInterval, offset circleOffset: Float, down movingDown: Bool)
    
    func updateCircleCenter()
    
}

protocol CustomTabBarPresenter: AnyObject {
    
    var view: CustomTabBarViewProtocol { get }
    
    func viewDidLoad()
    
    func viewDidAppear(portrait portraitOrientation: Bool)
    
    func viewDidRotate(portrait portraitOrientation: Bool, at index: Int)
    
    func tabBarDidSelectItem(with tag: Int)
    
    func viewWillLayoutSubviews()
    
    func moveCircleComplete(down movingDown: Bool)
    
}

class CustomTabBarPresenterClass: CustomTabBarPresenter {
    
    private struct Constants {
    
        static let smallRadius: Float = 25
        static let bigRadius: Float = 30
        static let smallCircle: Float = 47
        static let bigCircle: Float = 57
        static let circleAnimationDuration: TimeInterval = 0.2
        static let waveAnimationDuration: TimeInterval = Constants.circleAnimationDuration * 2
        static let showHideAnimationDuration: TimeInterval = 0.3
        
    }

    unowned let view: CustomTabBarViewProtocol
    private var isPortrait = true
    
    // MARK: - Initialization
    
    init(view: CustomTabBarViewProtocol) {
        self.view = view
    }
    
    // MARK: - CustomTabBarPresent functions
    
    func viewDidLoad() {
        view.disableTransparentTabBar()
        view.showTabBar(false, animated: false, over: Constants.showHideAnimationDuration)
    }
    
    func viewDidAppear(portrait portraitOrientation: Bool) {
        isPortrait = portraitOrientation
        view.showTabBar(true, animated: true, over: Constants.showHideAnimationDuration)
        view.setupTabBarTags()
        view.setupCurve(isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.setupCircle(isPortrait ? Constants.bigCircle : Constants.smallCircle)
        view.setupImageView((isPortrait ? Constants.bigCircle : Constants.smallCircle) / 2)
        view.setupTabBarColoring()
        view.setupTabBarBackground()
    }
    
    func viewDidRotate(portrait portraitOrientation: Bool, at index: Int) {
        isPortrait = portraitOrientation
        view.updateCircleSize(isPortrait ? Constants.bigCircle : Constants.smallCircle)
        view.updateImageViewSize((isPortrait ? Constants.bigCircle : Constants.smallCircle) / 2)
        view.moveCurve(with: Constants.waveAnimationDuration,
                       to: index,
                       with: isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.moveCircle(over: Constants.circleAnimationDuration,
                        offset: isPortrait ? Constants.bigRadius : Constants.smallRadius,
                        down: true)
    }
    
    func tabBarDidSelectItem(with tag: Int) {
        view.moveCurve(with: Constants.waveAnimationDuration,
                       to: tag,
                       with: isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.moveCircle(over: Constants.circleAnimationDuration,
                        offset: isPortrait ? Constants.bigRadius : Constants.smallRadius,
                        down: true)
    }
    
    func viewWillLayoutSubviews() {
        view.setupTabBarColoring()
    }
    
    func moveCircleComplete(down movingDown: Bool) {
        view.updateImageView()
        view.updateCircleCenter()
        if movingDown {
            view.moveCircle(over: Constants.circleAnimationDuration,
                            offset: isPortrait ? Constants.bigRadius : Constants.smallRadius,
                            down: false)
        }
    }
    
}
