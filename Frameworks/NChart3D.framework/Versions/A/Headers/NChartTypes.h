/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartTypes.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

/**
 * The NChartMargin struct stores the spacing of chart's elements.
 */
typedef struct
{
    /**
     * Spacing from the left side in pixels.
     */
    float left;
    
    /**
     * Spacing from the right side in pixels.
     */
    float right;
    
    /**
     * Spacing from the bottom side in pixels.
     */
    float bottom;
    
    /**
     * Spacing from the top side in pixels.
     */
    float top;
} NChartMargin;

/**
 * Create NChartMargin with given parameters.
 *
 * @param left - spacing from the left side in pixels.
 * @param right - spacing from the right side in pixels.
 * @param bottom - spacing from the bottom side in pixels.
 * @param top - spacing from the top side in pixels.
 * @return the margin.
 */
extern NChartMargin NChartMarginMake(float left, float right, float bottom, float top);

/**
 * The NChartZoomMode enum provides constants for different zoom modes.
 */
typedef NS_ENUM(NSInteger, NChartZoomMode)
{
    /**
     * Zoom is disabled.
     */
    NChartZoomModeNone,
    
    /**
     * Zoom is enabled and is always proportional.
     */
    NChartZoomModeProportional,
    
    /**
     * Zoom is enabled and is directional, so the user can zoom separately in the horizontal and vertical direction. By
     * diagonal direction zoom is proportional. Direction is determined as a vector that connects the user's fingers
     * during the pinch gesture.
     */
    NChartZoomModeDirectional
};

/**
 * The NChartUserInteraction enum provides constants to control available user intercation. You can use them to build
 * the mask of intercations availability by concatenating the needed ones with bitwise OR.
 */
typedef NS_ENUM(NSUInteger, NChartUserInteraction)
{
    /**
     * No intercations are available.
     */
    NChartUserInteractionNone = 0,
    
    /**
     * Vertical moving is available.
     */
    NChartUserInteractionVerticalMove = 1,
    
    /**
     * Horizontal moving is available.
     */
    NChartUserInteractionHorizontalMove = 2,
    
    /**
     * Vertical rotation is available.
     */
    NChartUserInteractionVerticalRotate = 4,
    
    /**
     * Horizontal rotation is available.
     */
    NChartUserInteractionHorizontalRotate = 8,
    
    /**
     * Vertical zoom is available.
     */
    NChartUserInteractionVerticalZoom = 16,
    
    /**
     * Horizontal zoom is available.
     */
    NChartUserInteractionHorizontalZoom = 32,
    
    /**
     * Proportional zoom is available.
     */
    NChartUserInteractionProportionalZoom = 64,
    
    /**
     * Tap is available.
     */
    NChartUserInteractionTap = 128,
    
    /**
     * All intercations are available.
     */
    NChartUserInteractionAll = 255
};

/**
 * The NChartAxisTickType enum provides constants to determine the ticks' layout on the axes.
 */
typedef NS_ENUM(NSInteger, NChartAxisTickType)
{
    /**
     * Ticks are on the inner side of the axis.
     */
    NChartAxisTickTypeInner,
    
    /**
     * Ticks are on the outer side of the axis.
     */
    NChartAxisTickTypeOuter,
    
    /**
     * Ticks are both on the inner and outer sides of the axis.
     */
    NChartAxisTickTypeBoth
};

/**
 * The NChartShadingModel provides constants for shading models used to shade 3D-objects.
 */
typedef NS_ENUM(NSInteger, NChartShadingModel)
{
    /**
     * Plain shading model, just filling with the corresponding color / gradient / texture / etc.
     */
    NChartShadingModelPlain,
    
    /**
     * Phong's shading model, filling with the corresponding color / gradient / texture / etc while shaded.
     */
    NChartShadingModelPhong
};

/**
 * The NChartLegendBlockAlignment enum provides constants for different predefined positions of the legend on the screen.
 */
typedef NS_ENUM(NSInteger, NChartLegendBlockAlignment)
{
    /**
     * Legend is in the top left corner of the screen.
     */
    NChartLegendBlockAlignmentTopLeft,
    
    /**
     * Legend is in the center on the top of the screen.
     */
    NChartLegendBlockAlignmentTopCenter,
    
    /**
     * Legend is in the top right corner of the screen.
     */
    NChartLegendBlockAlignmentTopRight,
    
    /**
     * Legend is on the left in the middle of the screen.
     */
    NChartLegendBlockAlignmentCenterLeft,
    
    /**
     * Legend is in the center of the screen.
     */
    NChartLegendBlockAlignmentCenterCenter,
    
    /**
     * Legend is on the right in the middle of the screen.
     */
    NChartLegendBlockAlignmentCenterRight,
    
    /**
     * Legend is in the bottom left corner of the screen.
     */
    NChartLegendBlockAlignmentBottomLeft,
    
    /**
     * Legend is in the center on the bottom of the screen.
     */
    NChartLegendBlockAlignmentBottomCenter,
    
    /**
     * Legend is in the bottom right corner of the screen.
     */
    NChartLegendBlockAlignmentBottomRight,
    
    /**
     * Legend fills the whole left area of the screen.
     */
    NChartLegendBlockAlignmentLeft,
    
    /**
     * Legend fills the whole right area of the screen.
     */
    NChartLegendBlockAlignmentRight,
    
    /**
     * Legend fills the whole bottom area of the screen.
     */
    NChartLegendBlockAlignmentBottom,
    
    /**
     * Legend fills the whole top area of the screen.
     */
    NChartLegendBlockAlignmentTop
};

/**
 * The NChartLegendOrientation enum provides constants for different legend docking modes.
 */
typedef NS_ENUM(NSInteger, NChartLegendOrientation)
{
    /**
     * Legend is fixed, you cannot alter the legend's origin, because it will be ignored.
     */
    NChartLegendOrientationFixed,
    
    /**
     * Legend is fixed by the Y-Axis, but free by the X-Axis, so you can alter the x-value of the origin and the y-value
     * will be ignored.
     */
    NChartLegendOrientationFreeHorizontal,
    
    /**
     * Legend is fixed by the X-Axis, but free by the Y-Axis, so you can alter the y-value of the origin and the x-value
     * will be ignored.
     */
    NChartLegendOrientationFreeVertical,
    
    /**
     * Legend is free by the X- and Y-Axis, so you can alter the origin.
     */
    NChartLegendOrientationFreeFloat
};

/**
 * The NChartLegendContentAlignment enum provides constants to align the legend's content in the legend area.
 */
typedef NS_ENUM(NSInteger, NChartLegendContentAlignment)
{
    /**
     * Align the content of the legend left.
     */
    NChartLegendContentAlignmentLeft,
    
    /**
     * Align the content of the legend to the center.
     */
    NChartLegendContentAlignmentCenter,
    
    /**
     * Align the content of the legend justified.
     */
    NChartLegendContentAlignmentJustified
};

/**
 * The NChartMarkerShape enum provides constants for markers' shapes.
 */
typedef NS_ENUM(NSInteger, NChartMarkerShape)
{
    /**
     * Do not display the marker.
     */
    NChartMarkerShapeNone,
    
    /**
     * Display a plain circle.
     */
    NChartMarkerShapeCircle,
    
    /**
     * Display a volumetric sphere.
     */
    NChartMarkerShapeSphere,
    
    /**
     * Display a custom 3D model.
     */
    NChartMarkerShapeModel
};

/**
 * The NChartTimeAxisTickShape enum provides constants to control the shape of ticks on the time axis.
 */
typedef NS_ENUM(NSInteger, NChartTimeAxisTickShape)
{
    /**
     * Ticks in the shape of a line.
     */
    NChartTimeAxisTickShapeLine,
    
    /**
     * Ticks in the shape of a triangle.
     */
    NChartTimeAxisTickShapeTriangle
};

/**
 * The NChartTimeAxisLabelsLayout enum provides constants to control the label's layout on the time axis.
 */
typedef NS_ENUM(NSInteger, NChartTimeAxisLabelsLayout)
{
    /**
     * Show all labels.
     */
    NChartTimeAxisShowAllLabels = 0,
    
    /**
     * Show the first and the last labels only.
     */
    NChartTimeAxisShowFirstLastLabelsOnly = 1
};

/**
 * The NChartTimeAxisLabelsPosition enum provides constants to the control label's positions on the time axis.
 */
typedef NS_ENUM(NSInteger, NChartTimeAxisLabelsPosition)
{
    /**
     * Place labels above the time axis.
     */
    NChartTimeAxisLabelsAbove,
    
    /**
     * Place labels beneath the time axis.
     */
    NChartTimeAxisLabelsBeneath
};

/**
 * The NChartValueAxesType enum provides constants of value axes types.
 */
typedef NS_ENUM(NSInteger, NChartValueAxesType)
{
    /**
     * Absolute type.
     */
    NChartValueAxesTypeAbsolute,
    
    /**
     * Additional type.
     */
    NChartValueAxesTypeAdditive,
    
    /**
     * Percent type.
     */
    NChartValueAxesTypePercent
};

/**
 * The NChartValueAxisKind enum provides constants to indicate the value axes.
 */
typedef NS_ENUM(NSInteger, NChartValueAxisKind)
{
    /**
     * X-axis.
     */
    NChartValueAxisX,
    
    /**
     * Secondary X-axis.
     */
    NChartValueAxisSX,
    
    /**
     * Y-axis.
     */
    NChartValueAxisY,
    
    /**
     * Secondary Y-axis.
     */
    NChartValueAxisSY,
    
    /**
     * Z-axis.
     */
    NChartValueAxisZ,
    
    /**
     * Secondary Z-axis.
     */
    NChartValueAxisSZ,
    
    /**
     * Azimuth-Axis.
     */
    NChartValueAxisAzimuth,
    
    /**
     * Radius-Axis.
     */
    NChartValueAxisRadius
};

/**
 * The NChartHighlightType enum provides constants to highligh points. You may use them to build a bitmask of highlight.
 * This means you may specify NChartHighlightTypeColor | NChartHighlightTypeShift to get highlight by color and highlight
 * by shift at the same time.
 */
typedef NS_ENUM(NSUInteger, NChartHighlightType)
{
    /**
     * No highlight.
     */
    NChartHighlightTypeNone = 0,
    
    /**
     * Highlight by color.
     */
    NChartHighlightTypeColor = 1,
    
    /**
     * Highlight by shift.
     */
    NChartHighlightTypeShift = 2,
    
    /**
     * Drop previous highlights. Add this to your highlight type combination if you do not want the highlights to
     * accumulate. This means, if there are some highlights queued by delay or not fully animated, they will be
     * cancelled.
     */
    NChartHighlightDrop = 4
};

/**
 * The NChartTooltipVerticalAlignment enum provides constants for vertical alignment of the tooltip.
 */
typedef NS_ENUM(NSUInteger, NChartTooltipVerticalAlignment)
{
    /**
     * Align tooltip on the top of it's pivot (the point it is connected with).
     */
    NChartTooltipVerticalAlignmentTop,
    
    /**
     * Align tooltip with it's pivot (the point it is connected with) in the center.
     */
    NChartTooltipVerticalAlignmentCenter,
    
    /**
     * Align tooltip on the bottom of it's pivot (the point it is connected with).
     */
    NChartTooltipVerticalAlignmentBottom
};

/**
 * The NChartTexturePosition enum provides constants that control position of texture.
 */
typedef NS_ENUM(NSUInteger, NChartTexturePosition)
{
    /**
     * Position texture in the top left corner of the area.
     */
    NChartTexturePositionTopLeftCorner,
    
    /**
     * Position texture at the center of the area.
     */
    NChartTexturePositionCenter,
    
    /**
     * Scale texture to fill the whole area.
     */
    NChartTexturePositionScale,
    
    /**
     * Scale texture keeping aspect so, that it fits in the area.
     */
    NChartTexturePositionScaleKeepMinAspect,
    
    /**
     * Scale texture keeping aspect so, that it covers the whole area.
     */
    NChartTexturePositionScaleKeepMaxAspect
};

/**
 * The NChartAnimationType enum provides constants to indicate different animations of the chart objects.
 */
typedef NS_ENUM(NSUInteger, NChartAnimationType)
{
    /**
     * Animation of transition from the one data set to the other.
     */
    NChartAnimationTypeTransition,
    
    /**
     * Animation of point highlighting.
     */
    NChartAnimationTypeHighlight
};

/**
 * The NChartCaptionBlockAlignment enum provides constants to control position of the caption's block.
 */
typedef NS_ENUM(NSUInteger, NChartCaptionBlockAlignment)
{
    /**
     * Align caption in the top left corner.
     */
    NChartCaptionBlockAlignmentTopLeft,
    /**
     * Align caption at the center on the top of the screen.
     */
    NChartCaptionBlockAlignmentTopCenter,
    /**
     * Align caption in the top right corner.
     */
    NChartCaptionBlockAlignmentTopRight,
    /**
     * Align caption in the bottom left corner.
     */
    NChartCaptionBlockAlignmentBottomLeft,
    /**
     * Align caption at the center on the bottom of the screen.
     */
    NChartCaptionBlockAlignmentBottomCenter,
    /**
     * Align caption in the bottom right corner.
     */
    NChartCaptionBlockAlignmentBottomRight
};

/**
 * The NChartValue enum provides constants to indicate values from the point states.
 */
typedef NS_ENUM(NSUInteger, NChartValue)
{
    /**
     * X value.
     */
     NChartValueX,
    
    /**
     * Y value.
     */
     NChartValueY,
    
    /**
     * Z value.
     */
     NChartValueZ,
    
    /**
     * Open value.
     */
    NChartValueOpen,
    
    /**
     * High value.
     */
    NChartValueHigh,
    
    /**
     * Low value.
     */
    NChartValueLow,
    
    /**
     * Close value.
     */
    NChartValueClose
};
