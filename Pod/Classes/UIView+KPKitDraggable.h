//
//  UIView+draggable.h
//  UIView+draggable
//
//  Created by Andrea on 13/03/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

@interface UIView (KPKitDraggable)

/**-----------------------------------------------------------------------------
 * @name UIView+draggable Properties
 * -----------------------------------------------------------------------------
 */

/** The pan gesture that handles the view dragging
 */
@property (nonatomic) UIPanGestureRecognizer *kp_panGesture;

/**-----------------------------------------------------------------------------
 * @name UIView+draggable Methods
 * -----------------------------------------------------------------------------
 */

/** Enables the dragging
 *
 * Enables the dragging state of the view
 */
- (void)kp_enableDragging;

/** Disable or enable the view dragging
 *
 * @param draggable The boolean that enables or disables the draggable state
 */
- (void)kp_setDraggable:(BOOL)draggable;

@end
