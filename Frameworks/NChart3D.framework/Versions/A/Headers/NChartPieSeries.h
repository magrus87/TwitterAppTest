/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartPieSeries.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartSolidSeries.h"
#import "NChartTooltip.h"


/**
 * The NChartPieSeries class provides methods to display pie series.
 */
@interface NChartPieSeries : NChartSolidSeries

@end

/**
 * The NChartPieSeriesSettings class provides global settings for <NChartPieSeries>.
 */
@interface NChartPieSeriesSettings : NChartSolidSeriesSettings

/**
 * Hole radius ratio that determines size of the hole for pie series relatively to the whole pie radius. The default
 * value 0.1.
 * @note This value cannot be less than 0 and greater than 1.0.
 */
@property (nonatomic, assign) float holeRatio;

/**
 * Caption that appears in the center of pie.
 * @see NChartTooltip.
 */
@property (nonatomic, retain) NChartTooltip *centerCaption;

@end
