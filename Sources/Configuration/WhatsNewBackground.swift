//
//  WhatsNewBackground.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit

extension WhatsNew.Design {
    /// Represents background options
    public enum Background {
        /// Set background to solid `UIColor`.
        case solid(UIColor?)
        
        /// Set Background to `Gradient`
        case gradient(Gradient)
        
        /// Set background to `UIImage`
        case image(UIImage?)
    }
    
    /// `UIView` subclass where the background can be configured using the `Background` enum.
    open class BackgroundView: UIView {
        internal var gradientView: GradientView?
        internal var imageView: UIImageView?
        
        /// The bounds rectangle, which describes the view's location and size in its own coordinate system.
        open override var bounds: CGRect {
            didSet {
                gradientView?.frame = bounds
                imageView?.frame = bounds
            }
        }
        
        /// View's `Background`.
        /// Settings this to `nil` will remove all background color, gradient and image.
        open var background: Background? {
            didSet {
                
                backgroundColor = nil
                setupImageView(for: nil)
                setupGradientView(for: nil)
                
                if let background = background {
                    switch background {
                    case .solid(let color):
                        backgroundColor = color
                    case .gradient(let gradient):
                        setupGradientView(for: gradient)
                    case .image(let uiImage):
                        setupImageView(for: uiImage)
                    }
                }
            }
        }
        
        internal func setupImageView(for image: UIImage?) {
            guard let image = image else {
                imageView?.removeFromSuperview()
                imageView = nil
                return
            }
            
            guard let view = imageView else {
                let newView = UIImageView(frame: frame)
                newView.contentMode = .scaleAspectFill
                imageView = newView
                insertSubview(newView, at: 0)
                setupImageView(for: image)
                return
            }
            
            view.image = image
        }
        
        internal func setupGradientView(for gradient: Gradient?){
            guard let gradient = gradient else {
                gradientView?.removeFromSuperview()
                gradientView = nil
                return
            }
            
            guard let view = gradientView else {
                let newView = GradientView(frame: frame)
                gradientView = newView
                insertSubview(newView, at: 0)
                setupGradientView(for: gradient)
                return
            }
            
            view.gradient = gradient
        }
    }
}
