//
//  SegmentedCircleView.m
//  Carbook
//
//  Created by user on 17.11.15.
//  Copyright © 2015 Notinum. All rights reserved.
//

#import "SegmentedCircleView.h"

@implementation ValueColorDTO

- (id)initWithValue:(CGFloat)value color:(UIColor *)color {
    if (self = [super init]) {
        _value = value;
        _color = color;
    }
    return self;
}

@end

@interface SegmentedCircleView()

@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic) CGFloat availableSpace;
@property (nonatomic, strong) UIBezierPath *circlePath;

@end

@implementation SegmentedCircleView

- (id)initWithFrame:(CGRect)frame duration:(CGFloat)duration strokeWidth:(CGFloat)strokeWidth valueColorArray:(NSArray<ValueColorDTO *> *)valueColorArray {
    if (self = [super initWithFrame:frame]) {
        _duration = duration;
        _strokeWidth = strokeWidth;
        _availableSpace = 1.;
        CGPoint arcCenter = CGPointMake(CGRectGetMidX(self.bounds),
                                        CGRectGetMidY(self.bounds));
        CGFloat radius = CGRectGetMidX(self.bounds) > CGRectGetMidY(self.bounds) ? CGRectGetMidY(self.bounds) - _strokeWidth / 2. : CGRectGetMidX(self.bounds) - _strokeWidth / 2.;
        self.circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                         radius:radius
                                                     startAngle:-M_PI/2
                                                       endAngle:-M_PI*2.5
                                                      clockwise:NO];
        [self addBackgroundLayer];
        
        CGFloat total = 0;
        for (ValueColorDTO *valueColor in valueColorArray) {
            total += valueColor.value;
        }
        
        for (ValueColorDTO *valueColor in valueColorArray) {
            [self addValueLayer:valueColor.color percentage:valueColor.value/total];
        }
    }
    return self;
}

- (void)addBackgroundLayer {
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.path = _circlePath.CGPath;
    backgroundLayer.strokeColor = [[UIColor colorWithWhite:.3 alpha:.3] CGColor];
    backgroundLayer.fillColor = [[UIColor clearColor] CGColor];
    backgroundLayer.lineWidth = _strokeWidth;
    
    [self.layer addSublayer:backgroundLayer];
}

- (void)addValueLayer:(UIColor *) color percentage:(CGFloat)percentage {
    CAShapeLayer *percentageLayer = [CAShapeLayer layer];
    percentageLayer.path = _circlePath.CGPath;
    percentageLayer.strokeColor = [color CGColor];
    percentageLayer.fillColor = [[UIColor clearColor] CGColor];
    percentageLayer.lineWidth = _strokeWidth;
    percentageLayer.strokeEnd = 0;
    
    [self.layer addSublayer:percentageLayer];
    
    CABasicAnimation *percentageLayerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    percentageLayerAnimation.duration = _duration;
    percentageLayerAnimation.fromValue = @(percentageLayer.strokeEnd);
    percentageLayerAnimation.toValue = @(_availableSpace);
    [percentageLayer addAnimation:percentageLayerAnimation forKey:@"strokeEndAnimation"];
    percentageLayer.strokeEnd = _availableSpace;
    
    _availableSpace -= percentage;
    if (_availableSpace < 0)
        _availableSpace = 0;
}

@end
