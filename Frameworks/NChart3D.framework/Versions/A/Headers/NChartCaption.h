/**
 * This file is the part of NChart3D Framework
 * http://www.nchart3d.com
 *
 * File: NChartCaption.h
 * Version: "1.7"
 *
 * Copyright (C) 2014 Nulana LTD. All Rights Reserved.
 */

#import "NChartLabel.h"


/**
 * The NChartCaption class provides methods to display caption of the chart.
 */
@interface NChartCaption : NChartLabel

/**
 * Alignment of the caption. The default calue is <code>NChartCaptionBlockAlignmentTopCenter</code>.
 * @see NChartCaptionBlockAlignment.
 */
@property (nonatomic, assign) NChartCaptionBlockAlignment blockAlignment;

@end
