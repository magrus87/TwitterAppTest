/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartTooltip.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartLabel.h"


/**
 * The NChartTooltip class provides methods to display the tooltip for the chart's points.
 */
@interface NChartTooltip : NChartLabel

/**
 * Change visibility of tooltip animated.
 *
 * @param visible - flag of visibility.
 * @param duration - duration of animation in seconds.
 */
- (void)setVisible:(BOOL)visible animated:(float)duration;

/**
 * Vertical alignment of the tooltip. It is used if tooltip has no arrow presented, otherwise it is ignored.
 * @see NChartTooltipVerticalAlignment.
 */
@property (nonatomic, assign) NChartTooltipVerticalAlignment verticalAlignment;

/**
 * Flag determining if the tooltip should always be inside of the chart's plot area. If YES, the tooltip may be shifted
 * to fit in the plot area when it's pivot is near the border of the chart's plot area. If NO, it is never shifted
 * and can overlap the axis when it's pivot is near the border of the chart's plot area. The default value is YES.
 */
@property (nonatomic, assign) BOOL alwaysInPlotArea;

@end
