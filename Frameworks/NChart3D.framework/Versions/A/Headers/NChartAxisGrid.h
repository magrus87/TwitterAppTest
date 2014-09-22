/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartAxisGrid.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartObject.h"


/**
 * The NChartAxisGrid class provides methods to display the grid for the chart's axes.
 */
@interface NChartAxisGrid : NChartObject

/**
 * Color of the grid lines.
 */
@property (nonatomic, retain) UIColor *color;

/**
 * Thickness of the grid lines in pixels. The default value is 1.
 */
@property (nonatomic, assign) float thickness;

@end
