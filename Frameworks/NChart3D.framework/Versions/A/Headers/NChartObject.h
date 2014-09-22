/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartObject.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import <Foundation/Foundation.h>
#import "NChartTypes.h"


/**
 * The NChartObject class provides common methods for all the objects on the chart.
 */
@interface NChartObject : NSObject

/**
 * Flag that determines if the object is visible (YES) or not (NO). The default value is YES.
 */
@property (nonatomic, assign) BOOL visible;

@end
