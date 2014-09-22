//
//  TTChartView.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 22.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTChartView.h"

#define CAPTION_LABEL_HEIGHT                        40.0f
#define LEGEND_VIEW_HEIGHT                          50.0f

#define LEGEND_COLOR_MARKER_BOUNDS_WIDTH            15.0f
#define LEGEND_COLOR_MARKER_BOUNDS_HEIGHT           15.0f
#define LEGEND_COLUMN_COUNT                         2
#define LEGEND_ROW_COUNT                            2
#define LEGEND_PADDING_X                            15
#define LEGEND_PADDING_BETWENN_ELEMENTS_X           10
#define LEGEND_PADDING_Y                            7
#define LEGEND_PADDING_BETWENN_ELEMENTS_Y           6
#define LEGEND_PADDING_BETWENN_MARKER_TEXT          5


#define SCALE_Y_WIDTH                               40.0
#define SCALE_LABEL_HEIGHT                          10.0


#define CHART_MARGIN_X                              10.0f
#define CHART_MARGIN_Y                              10.0f
#define CHART_ARROW_HEIGHT                          5.0f
#define CHART_MARGIN_WIDTH_COLUMN                   15.0f
#define CHART_KOEF_HEIGHT_COLUMN                    50.0f


@interface TTChartView()

@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSArray *series;

@end


@implementation TTChartView {
    UILabel *captionLable;
    UIView *legendView;
    UIView *scaleYView;

    CGFloat _maxValue;
    CGFloat _minValue;

    CGFloat heightChart;
    CGFloat widthChart;
    CGFloat koefHeightScale;
    CGFloat incrementToMaxValue;
    CGFloat countNicksOnScale;
}

-(void)initialize {
    _colors = [UIColor defaultColorsForChart];


    heightChart = self.frame.size.height - CAPTION_LABEL_HEIGHT - LEGEND_VIEW_HEIGHT - 2*CHART_MARGIN_Y - CHART_ARROW_HEIGHT;
    widthChart = self.frame.size.width - SCALE_Y_WIDTH - 2*CHART_MARGIN_X - CHART_ARROW_HEIGHT;

    _maxValue = -MAXFLOAT;
    _minValue = MAXFLOAT;



    CGFloat minDelta = MAXFLOAT;
    CGFloat maxDelta = 0;

    CGFloat prevValue = 0;

    self.series = self.delegate.series;
    for (NSArray *serie in self.series) {
        CGFloat value = [[serie objectAtIndex:0] floatValue];

        CGFloat delta = ABS(value - prevValue);
        if (delta > maxDelta)
            maxDelta = delta;
        if (delta < minDelta)
            minDelta = delta;
        prevValue = value;



        if (value > _maxValue)
            _maxValue = value;
        if (value < _minValue)
            _minValue = value;
    }

    if (minDelta == 0)
        minDelta++;


    koefHeightScale = heightChart/_maxValue;
    incrementToMaxValue = heightChart/minDelta;
    countNicksOnScale = floorf(maxDelta/minDelta);

}

-(void)layoutSubviews {
    [super layoutSubviews];

    [self initialize];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    self.backgroundColor = [UIColor whiteColor];

    captionLable = [[UILabel alloc] init];
    captionLable.frame = CGRectMake(0, 0, self.bounds.size.width, CAPTION_LABEL_HEIGHT);
    captionLable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    captionLable.textAlignment = NSTextAlignmentCenter;
    captionLable.numberOfLines = 2;
    captionLable.text = [self.delegate respondsToSelector:@selector(captionText)] ? self.delegate.captionText : @"";
    captionLable.font = SYSTEM_FONT(15.0);
    [self addSubview:captionLable];


    [self makeLegendView];
    [self makeScaleY];

}

-(void)makeLegendView {

    legendView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - LEGEND_VIEW_HEIGHT, self.bounds.size.width, LEGEND_VIEW_HEIGHT)];
    legendView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:legendView];

    CGFloat yPos = LEGEND_PADDING_BETWENN_ELEMENTS_Y;
    for (int i = 0; i < self.series.count; i++) {

        NSArray *seriesValue = [self.series objectAtIndex:i];

        if (i%2 == 0 && i > 0) {
            yPos += floorf(legendView.bounds.size.height/LEGEND_ROW_COUNT);
        }

        CGRect rect = CGRectMake(
                                 floorf(LEGEND_PADDING_X + (self.bounds.size.width/LEGEND_COLUMN_COUNT)*(i%LEGEND_COLUMN_COUNT)),
                                 yPos,
                                 floorf((self.bounds.size.width/LEGEND_COLUMN_COUNT) - (LEGEND_PADDING_BETWENN_ELEMENTS_X/2) - LEGEND_PADDING_X),
                                 floorf((legendView.bounds.size.height/LEGEND_ROW_COUNT) - (LEGEND_PADDING_BETWENN_ELEMENTS_Y/2) - LEGEND_PADDING_Y)
                                 );
        NSString *textElement = [seriesValue objectAtIndex:1];

        CALayer *hrLayer = [[CALayer alloc] init];
        hrLayer.frame = CGRectMake(0, 0, LEGEND_COLOR_MARKER_BOUNDS_WIDTH, LEGEND_COLOR_MARKER_BOUNDS_HEIGHT);
        hrLayer.backgroundColor = ((UIColor *)[_colors objectAtIndex:i]).CGColor;//(self.delegate.colors && self.delegate.colors.count > i ? ((UIColor *)[self.delegate.colors objectAtIndex:i]).CGColor : ((UIColor *)[_colors objectAtIndex:i]).CGColor);
        hrLayer.anchorPoint = CGPointMake(0, 0);
        hrLayer.position = CGPointMake(rect.origin.x, rect.origin.y);
        [legendView.layer addSublayer:hrLayer];

        UILabel *textLegendLabel = [[UILabel alloc] init];
        textLegendLabel.frame = CGRectMake(hrLayer.position.x + hrLayer.frame.size.width + LEGEND_PADDING_BETWENN_MARKER_TEXT, rect.origin.y, rect.size.width, rect.size.height);
        textLegendLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        textLegendLabel.textAlignment = NSTextAlignmentLeft;
        textLegendLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        textLegendLabel.numberOfLines = 1;
        textLegendLabel.text = textElement;
        textLegendLabel.font = SYSTEM_FONT(12.0);
        [legendView addSubview:textLegendLabel];
    }


}

-(void)makeScaleY {

    scaleYView = [[UIView alloc] initWithFrame:CGRectMake(0, captionLable.frame.size.height, SCALE_Y_WIDTH, self.bounds.size.height - captionLable.frame.size.height - legendView.frame.size.height)];
    scaleYView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:scaleYView];

    NSUInteger stepOnScaleY = (int)ceil(_maxValue/(countNicksOnScale + 1));

    UILabel *label;

    label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, floor(scaleYView.bounds.size.height - CHART_MARGIN_Y - SCALE_LABEL_HEIGHT/2), scaleYView.bounds.size.width, SCALE_LABEL_HEIGHT);
    label.text = [NSString stringWithFormat:@"%d", 0];
    label.font = SYSTEM_FONT(10.0);
    label.textAlignment = NSTextAlignmentRight;
    [scaleYView addSubview:label];

    for (int i = 0; i < stepOnScaleY; i++) {

        label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, floor(scaleYView.bounds.size.height - CHART_MARGIN_Y - SCALE_LABEL_HEIGHT/2 - (koefHeightScale*stepOnScaleY)*(i+1)), scaleYView.bounds.size.width, SCALE_LABEL_HEIGHT);
        label.text = [NSString stringWithFormat:@"%d", (int)floorf(stepOnScaleY*(i+1))];
        label.font = SYSTEM_FONT(10.0);
        label.textAlignment = NSTextAlignmentRight;
        [scaleYView addSubview:label];
    }

    label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, floor(CHART_MARGIN_Y + CHART_ARROW_HEIGHT - SCALE_LABEL_HEIGHT/2), scaleYView.bounds.size.width, SCALE_LABEL_HEIGHT);
    label.text = [NSString stringWithFormat:@"%d", (int)floorf(_maxValue)];
    label.font = SYSTEM_FONT(10.0);
    label.textAlignment = NSTextAlignmentRight;
    [scaleYView addSubview:label];
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextClipToRect(context, rect);

    CGContextTranslateCTM(context, 0, CGRectGetHeight(self.bounds));
    CGContextScaleCTM(context, 1, -1);


    CGPoint zeroPoint = CGPointMake(scaleYView.frame.size.width + CHART_MARGIN_X, legendView.frame.size.height + CHART_MARGIN_Y);


    //рисуем систему координат
    CGContextBeginPath (context);
    //vertical
    CGContextMoveToPoint(context, zeroPoint.x, zeroPoint.y);
    CGContextAddLineToPoint(context, zeroPoint.x, zeroPoint.y + heightChart + CHART_ARROW_HEIGHT);
    CGContextAddLineToPoint(context, zeroPoint.x - 3, zeroPoint.y + heightChart);
    CGContextMoveToPoint(context, zeroPoint.x, zeroPoint.y + heightChart + CHART_ARROW_HEIGHT);
    CGContextAddLineToPoint(context, zeroPoint.x + 3, zeroPoint.y + heightChart);
    //horizontal
    CGContextMoveToPoint(context, zeroPoint.x, zeroPoint.y);
    CGContextAddLineToPoint(context, zeroPoint.x + widthChart + CHART_ARROW_HEIGHT, zeroPoint.y);
    CGContextAddLineToPoint(context, zeroPoint.x + widthChart, zeroPoint.y - 3);
    CGContextMoveToPoint(context, zeroPoint.x + widthChart + CHART_ARROW_HEIGHT, zeroPoint.y);
    CGContextAddLineToPoint(context, zeroPoint.x + widthChart, zeroPoint.y + 3);
    CGContextStrokePath(context);



    //рисуем серии

    CGFloat widthColumn = floor(widthChart/self.series.count - CHART_MARGIN_WIDTH_COLUMN);

    for (int i = 0; i < self.series.count; i++)
    {
        NSArray *serie = [self.series objectAtIndex:i];

        CGFloat x = floor(zeroPoint.x + widthColumn*i + CHART_MARGIN_WIDTH_COLUMN*(i+0.5));
        CGFloat heightColumn = koefHeightScale*[[serie objectAtIndex:0] intValue];

        NSArray *colorComponents = [UIColor getRGBComponentsForColor:[self.colors objectAtIndex:i]];

        CGContextSetRGBFillColor (context, [[colorComponents objectAtIndex:0] floatValue], [[colorComponents objectAtIndex:1] floatValue], [[colorComponents objectAtIndex:2] floatValue], [[colorComponents objectAtIndex:3] floatValue]);
        CGContextBeginPath (context);
        CGContextAddRect(context, CGRectMake(x, zeroPoint.y, widthColumn, heightColumn));
        CGContextFillPath(context);
        CGContextStrokePath(context);
    }

}







@end
