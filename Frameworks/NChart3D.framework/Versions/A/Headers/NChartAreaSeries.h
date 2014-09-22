/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartAreaSeries.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartSolidSeries.h"
#import "NChartMarker.h"


/**
 * The NChartAreaSeries class provides methods to display area series.
 */
@interface NChartAreaSeries : NChartSolidSeries

/**
 * Marker that is shown on the points. This is nil by default (no marker is displayed).
 * @see NChartMarker.
 */
@property (nonatomic, retain) NChartMarker *marker;

@end

/**
 * The NChartAreaSeriesSettings class provides global settings for <NChartAreaSeries>.
 */
@interface NChartAreaSeriesSettings : NChartSolidSeriesSettings

@end
