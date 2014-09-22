/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartCartesianSystem.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartCoordSystem.h"
#import "NChartValueAxis.h"
#import "NChartAxesPlane.h"
#import "NChartAxisGrid.h"


/**
 * The NChartCartesianSystem class provides methods for managing the chart's cartesian coordinate system.
 */
@interface NChartCartesianSystem : NChartCoordSystem

/**
 * X-axis of the cartesian coordinate system.
 * @see NChartValueAxis.
 */
@property (nonatomic, readonly) NChartValueAxis *xAxis;

/**
 * Secondary X-axis of the cartesian coordinate system.
 * @see NChartValueAxis.
 */
@property (nonatomic, readonly) NChartValueAxis *sxAxis;

/**
 * Y-axis of the cartesian coordinate system.
 * @see NChartValueAxis.
 */
@property (nonatomic, readonly) NChartValueAxis *yAxis;

/**
 * Secondary Y-axis of the cartesian coordinate system.
 * @see NChartValueAxis.
 */
@property (nonatomic, readonly) NChartValueAxis *syAxis;

/**
 * Z-axis of the cartesian coordinate system.
 * @see NChartValueAxis.
 */
@property (nonatomic, readonly) NChartValueAxis *zAxis;

/**
 * Secondary Z-axis of the cartesian coordinate system.
 * @see NChartValueAxis.
 */
@property (nonatomic, readonly) NChartValueAxis *szAxis;

/**
 * XY-axes plane of the cartesian coordinate system.
 * @see NChartAxesPlane.
 */
@property (nonatomic, readonly) NChartAxesPlane *xyPlane;

/**
 * XZ-axes plane of the cartesian coordinate system.
 * @see NChartAxesPlane.
 */
@property (nonatomic, readonly) NChartAxesPlane *xzPlane;

/**
 * YZ-axes plane of the cartesian coordinate system.
 * @see NChartAxesPlane.
 */
@property (nonatomic, readonly) NChartAxesPlane *yzPlane;

/**
 * Grid that goes from the X-axis along the Y-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *xAlongY;

/**
 * Grid that goes from the X-axis along the Z-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *xAlongZ;

/**
 * Grid that goes from secondary the X-axis along the Y-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *sxAlongY;

/**
 * Grid that goes from secondary the X-axis along the Z-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *sxAlongZ;

/**
 * Grid that goes from the Y-axis along the X-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *yAlongX;

/**
 * Grid that goes from the Y-axis along the Z-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *yAlongZ;

/**
 * Grid that goes from secondary the Y-axis along the X-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *syAlongX;

/**
 * Grid that goes from secondary the Y-axis along the Z-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *syAlongZ;

/**
 * Grid that goes from the Z-axis along the X-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *zAlongX;

/**
 * Grid that goes from the Z-axis along the Y-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *zAlongY;

/**
 * Grid that goes from secondary the Z-axis along the X-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *szAlongX;

/**
 * Grid that goes from secondary the Z-axis along the Y-axis.
 * @see NChartAxisGrid.
 */
@property (nonatomic, readonly) NChartAxisGrid *szAlongY;

/**
 * Type of axes. You may use additional and percent axes only if you provide ticks for category axes. For example, if
 * you are about to display additional columns, you should provide ticks for the X and Z axes. If you are about to
 * display additional bars, you should provide ticks for Y and Z axes respectively (because bars are stretched along
 * the X-axis).
 * If you didn't provide ticks for category axes, changing the type to additional or percent takes no effect for the
 * series displayed even though states of their points are aligned to the grid (see <NChartPointState> for details).
 * @see NChartValueAxesType.
 */
@property (nonatomic, assign) NChartValueAxesType valueAxesType;

/**
 * Flag that determines if the border around the cartesian coordinate system is visible (YES) or not (NO).
 */
@property (nonatomic, assign) BOOL borderVisible;

/**
 * Color of the border around the cartesian coordinate system.
 */
@property (nonatomic, assign) UIColor *borderColor;

/**
 * Thickness of the border around the cartesian coordinate system.
 */
@property (nonatomic, assign) float borderThickness;

@end
