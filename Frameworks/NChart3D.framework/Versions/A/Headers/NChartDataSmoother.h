/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartDataSmoother.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartTypes.h"


/**
 * The NChartDataSmoother class provides basic data smoother used to create smooth charts by only a few points.
 */
@interface NChartDataSmoother : NSObject

/**
 * Create new instance of data smoother.
 */
+ (id)dataSmoother;

@end

/**
 * The NChartDataSmoother2D class provides data smoother used to create smooth lines on the charts by only a few points.
 * Typically this smoother is used for line and area series.
 */
@interface NChartDataSmoother2D : NChartDataSmoother

/**
 * Maximal step that should be between two points. Normally it is detected automatically, however you always can
 * override it.
 * @see shouldAutodetectStep.
 */
@property (nonatomic, assign) double step;

/**
 * Flag determining if step should be autodetected (YES) or not (NO). The default value is YES. If you assign
 * <code>step</code> property, this value is automatically set to NO.
 * @see step.
 */
@property (nonatomic, assign) BOOL shouldAutodetectStep;

/**
 * Resolution of the spline. Normally it is detected automatically, however you always can override it.
 * Resolution is the number of subdivisions by the step dimension.
 * @see shouldAutodetectResolution.
 */
@property (nonatomic, assign) int resolution;

/**
 * Flag determining if resolution should be autodetected (YES) or not (NO). The default value is YES. If you assign
 * <code>resolution</code> property, this value is automatically set to NO.
 * @see resolution.
 */
@property (nonatomic, assign) BOOL shouldAutodetectResolution;

/**
 * Key of the value that should be interpreted as step dimention. Typically it is NChartValueX (which is the default
 * value), however for bar series it should be NChartValueY.
 */
@property (nonatomic, assign) NChartValue stepDimension;

/**
 * Key of the value that should be interpreted as height dimension. Typically it is NChartValueY (which is the default
 * value), however for bar series it should be NChartValueX.
 */
@property (nonatomic, assign) NChartValue valueDimension;

@end
