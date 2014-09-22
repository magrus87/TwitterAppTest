/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartValueAxis.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartAxis.h"
#import "NChartAxisTicks.h"
#import "NChartLabel.h"


@class NChartValueAxis;

/**
 * The NChartValueAxisDataSource protocol provides methods to control data displayed on value axis.
 */
@protocol NChartValueAxisDataSource <NSObject>

@optional

/**
 * Get the name that is displayed in the axis' caption.
 *
 * @param axis - axis to get the name for.
 * @return the name of the axis.
 * @see NChartValueAxis.
 */
- (NSString *)valueAxisDataSourceNameForAxis:(NChartValueAxis *)axis;

/**
 * Get the minimal value for the axis. If there is no implementation, the axis is assumed to be discrete and you should
 * provide an array of ticks. If neither min and max nor an array of ticks are provided, the axis is assumed to be
 * continuous and both min and max are calculated automatically based on the values for the series.
 *
 * @param axis - axis to get minimal value for.
 * @return the minimal value for the axis. It may be nil that is equivalent to the absence of implementation.
 * @see NChartValueAxis.
 */
- (NSNumber *)valueAxisDataSourceMinForValueAxis:(NChartValueAxis *)axis;

/**
 * Get the maximal value for the axis. If there is no implementation, the axis is assumed to be discrete and you should
 * provide an array of ticks. If neither min and max nor an array of ticks are provided, the axis is assumed to be
 * continuous and both min and max are calculated automatically based on the values for the series.
 *
 * @param axis - axis to get the maximal value for.
 * @return the maximal value for the axis. It may be nil that is equivalent to the absence of implementation.
 * @see NChartValueAxis.
 */
- (NSNumber *)valueAxisDataSourceMaxForValueAxis:(NChartValueAxis *)axis;

/**
 * Get step value for axis. If there is no implementation, the step, min and max values are beautified.
 *
 * @param axis - axis to get the step value for.
 * @return the step value for the axis. It may be nil that is equivalent to the absence of implementation.
 * @see NChartValueAxis.
 */
- (NSNumber *)valueAxisDataSourceStepForValueAxis:(NChartValueAxis *)axis;

/**
 * Get array of ticks for the discrete axis. You should provide it if min and max are not implemented. If they are
 * implemented, the array of ticks is ignored. If neither min and max nor the array of ticks are provided, axis is
 * assumed to be continuous and both min and max are calculated automatically based on the values for the series.
 *
 * @param axis - axis to get an array of ticks for.
 * @return an array of strings that represent the ticks. It may be nil that is equivalent to the absence of implementation.
 * @see NChartValueAxis.
 */
- (NSArray *)valueAxisDataSourceTicksForValueAxis:(NChartValueAxis *)axis;

/**
 * Get length of axis in 3D scene units. If there is no implementation, 1 is used. See length of <NChartValueAxis> for
 * details.
 *
 * @param axis - axis to get the length for.
 * @return the length of the axis. It may be nil that is equivalent to the absence of implementation.
 * @see NChartValueAxis.
 */
- (NSNumber *)valueAxisDataSourceLengthForValueAxis:(NChartValueAxis *)axis;

/**
 * Convert double value to string.
 *
 * @param axis - axis to convert value for.
 * @param value - value to convert.
 * @return string representation of the value.
 * @see NChartValueAxis.
 */
- (NSString *)valueAxisDataSourceDouble:(double)value toStringForValueAxis:(NChartValueAxis *)axis;

@end

/**
 * The NChartValueAxis class provides methods to display the value axis of the chart.
 */
@interface NChartValueAxis : NChartAxis

/**
 * Kind of axis.
 * @see NChartValueAxisKind.
 */
@property (nonatomic, readonly) NChartValueAxisKind kind;

/**
 * Minimal value on the axis. It is obtained from the data source and, if needed, processed to look more beautiful.
 */
@property (nonatomic, readonly) double minValue;

/**
 * Maximal value on the axis. It is obtained from the data source and, if needed, processed to look more beautiful.
 */
@property (nonatomic, readonly) double maxValue;

/**
 * Step from one tick to another. It is either obtained from the data source or, if not provided, calculated according
 * to the <minValue> and <maxValue> to look beautiful.
 */
@property (nonatomic, readonly) double step;

/**
 * Array of strings that are displayed as ticks on the axis. It is obtained from the data source or nil if not provided.
 */
@property (nonatomic, readonly) NSArray *ticks;

/**
 * Number of ticks on the axis. It is the number of ticks in an array or the number of values between
 * <minValue> and <maxValue> through <step>.
 */
@property (nonatomic, readonly) int tickCount;

/**
 * Length of axis in 3D scene units. This value is obtained from the data source or, if not provided, is assigned to 1.
 * It has an effect for axes being displayed in 3D only. In 2D this value is ignored because axes fill the whole area
 * available on the screen. One 3D scene unit is equal to half a screen size by initial zoom (so space of the 3D scene
 * is actually nonlinear respective to the screen). Therefore, by default all axes have equal length and form a kind of
 * cube in 3D that is centered on the screen and is as big as half of the biggest screen's dimension. However, if you
 * want, for example, to make the Z-axis shorter than the others, you can provide a length of 0.5 for it. It will
 * therefore be twice as short as the others.
 */
@property (nonatomic, readonly) float length;

/**
 * Color of the axis line.
 */
@property (nonatomic, retain) UIColor *color;

/**
 * Font for the ticks' labels.
 */
@property (nonatomic, retain) UIFont *font;

/**
 * Color of the text for the ticks' labels.
 */
@property (nonatomic, retain) UIColor *textColor;

/**
 * Flag that determines if there should be an offset on the axis. The offset is the spacing from the beginning of the
 * axis to the first tick and from the last tick to the end of the axis. If this flag is YES, the spacing is half a step.
 * If NO, spacing is zero.
 */
@property (nonatomic, assign) BOOL hasOffset;

/**
 * Minimal spacing between neighbor ticks in pixels (the tick is the center place of the timestamp title, a kind of
 * milestone on the axis). According to this value some timestamps can be hidden, if there are too many of them.
 */
@property (nonatomic, assign) float minTickSpacing;

/**
 * Thickness of the axis' line in pixels.
 */
@property (nonatomic, assign) float thickness;

/**
 * Major ticks of the axis. Major ticks are spread from the <minValue> to the <maxValue> through <step> or, if no
 * <minValue> and <maxValue> are provided but a ticks array is provided, the whole axis length is divided by the number
 * of ticks and for each tick there is a major tick displayed.
 * @see NChartAxisTicks.
 */
@property (nonatomic, readonly) NChartAxisTicks *majorTicks;

/**
 * Minor ticks of the axis. Minor ticks are displayed in the middle between two neighbor major ticks. See majorTicks
 * for details.
 * @see NChartAxisTicks.
 */
@property (nonatomic, readonly) NChartAxisTicks *minorTicks;

/**
 * Caption of the axis.
 * @see NChartLabel.
 */
@property (nonatomic, readonly) NChartLabel *caption;

/**
 * Flag that determines if the labels of ticks are visible (YES) or not (NO). The default value is YES.
 */
@property (nonatomic, assign) BOOL labelsVisible;

/**
 * Flag that determines if the line of the axis is visible (YES) or not (NO). The default value is YES.
 */
@property (nonatomic, assign) BOOL lineVisible;

/**
 * Flag that determines whether zero is always on the axis. This flag makes sense if <minValue> and <maxValue> are both
 * less or greater than zero and are beautified according to the data source. In this case, if this flag is false, it
 * may happen, that no zero will be on the axis (for example, if <minValue> = 11.5 and <maxValue> = 19, the axis will
 * probably start with 10 and end with 20, having 4 steps). With this flag set to true, zero will always be on the axis,
 * so even with <minValue> = 11.5 and <maxValue> = 19 the axis will start with 0 and end with 20 having probably 5 steps
 * or so. The default value is NO.
 */
@property (nonatomic, assign) BOOL alwaysShowZero;

/**
 * Flag that determines whether the axis labels are in "perspective" screen (YES) or are projected in the 2D screen (NO).
 * This flag only affects 3D-charts. The default value is YES.
 */
@property (nonatomic, assign) BOOL labelsIn3D;

/**
 * Flag that determines whether the axis caption is in "perspective" screen (YES) or is projected in the 2D screen (NO).
 * This flag only affects 3D-charts. The deafult value is YES.
 */
@property (nonatomic, assign) BOOL captionIn3D;

/**
 * Flag that detemines whether min and max values on the axis should be beautified in case they are calculated (YES)
 * or not (NO). The default vaule is YES.
 */
@property (nonatomic, assign) BOOL shouldBeautifyMinAndMax;

/**
 * Axis labels' rotation angle. This property takes effect in 3D mode only (<code>chart.drawIn3D == YES</code>) and
 * if labels are drawn in "perspective" screen (<code>labelsIn3D == YES</code>).
 * @see NChart, property drawIn3D.
 * @see labelsIn3D.
 */
@property (nonatomic, assign) float labelsAngle;

/**
 * Data source of the axis.
 * @see NChartValueAxisDataSource.
 */
@property (nonatomic, assign) id<NChartValueAxisDataSource> dataSource;

/**
 * Zoom to given region by specifying the least and the greatest values that should be visible on the axis. If the
 * axis has array of ticks, indices in this array can be used. Use this method after you updated data of the chart
 * with <code>[chart updateData]</code> call.
 *
 * @param startValue - least value that should be visible.
 * @param endValue - greatest value that should be visible.
 * @param duration - duration of the animation in seconds.
 * @param delay - delay of animation in seconds.
 */
- (void)zoomToRegionFrom:(float)startValue to:(float)endValue duration:(float)duration delay:(float)delay;

@end
