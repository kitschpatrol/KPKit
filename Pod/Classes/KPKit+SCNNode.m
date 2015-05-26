//
//  KPKit+SCNNode.m
//  Pods
//
//  Created by Eric Mika on 2/26/15.
//
//

#import "KPKit+SCNNode.h"

@implementation SCNNode (KPKit)

- (GLKVector3)kp_glkPosition
{
  return SCNVector3ToGLKVector3(self.position);
}
- (void)setKp_glkPosition:(GLKVector3)kp_glkPosition
{
  self.position = SCNVector3FromGLKVector3(kp_glkPosition);
}

@end
