/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartView.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NChart.h"


/**
 * The NChartView class provides a view to display the chart. This view can be added anywhere to view the hierarchy of
 * the app.
 */
@interface NChartView : UIView

/**
 * Get chart instance. It is created with the view's creation and destroyed with its destruction.
 * @see NChart.
 */
@property (nonatomic, readonly) NChart *chart;

@end
