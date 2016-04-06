//
//  SegmentedCircleView.h
//  Carbook
//
//  Created by user on 17.11.15.
//  Copyright © 2015 Notinum. All rights reserved.
//

#import <UIKit/UIKit.h>

// http://subjc.com/spark-camera/
// http://stackoverflow.com/questions/30466915/draw-arc-segments-using-uibezierpath
// https://github.com/natalia-osa/CircleStatus

@interface ValueColorDTO : NSObject

@property (nonatomic) CGFloat value;
@property (nonatomic, strong) UIColor *color;

- (id)initWithValue:(CGFloat)value color:(UIColor *)color;

@end

@interface SegmentedCircleView : UIView

- (id)initWithFrame:(CGRect)frame duration:(CGFloat)duration strokeWidth:(CGFloat)strokeWidth valueColorArray:(NSArray<ValueColorDTO *> *)valueColorArray;

@end
