/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartLineSeries.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartSolidSeries.h"
#import "NChartMarker.h"


/**
 * The NChartLineSeries class provides methods to display line series.
 */
@interface NChartLineSeries : NChartSolidSeries

/**
 * Color of the line in the points with no data.
 */
@property (nonatomic, retain) UIColor *noDataColor;

/**
 * Thickness of the line in pixels. The default value is 2.
 */
@property (nonatomic, assign) float lineThickness;

/**
 * Marker that is shown on the points. This is nil by default (no marker is displayed).
 * @see NChartMarker.
 */
@property (nonatomic, retain) NChartMarker *marker;

@end

/**
 * The NChartLineSeriesSettings class provides global settings for <NChartLineSeries>.
 */
@interface NChartLineSeriesSettings : NChartSeriesSettings

@end
