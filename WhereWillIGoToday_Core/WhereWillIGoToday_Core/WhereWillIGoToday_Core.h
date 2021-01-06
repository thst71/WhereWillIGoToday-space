//
//  WhereWillIGoToday_Core.h
//  WhereWillIGoToday_Core
//
//  Created by Thomas Strauß on 06.11.16.
//  Copyright © 2016 Thomas Strauß. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for WhereWillIGoToday_Core.
FOUNDATION_EXPORT double WhereWillIGoToday_CoreVersionNumber;

//! Project version string for WhereWillIGoToday_Core.
FOUNDATION_EXPORT const unsigned char WhereWillIGoToday_CoreVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WhereWillIGoToday_Core/PublicHeader.h>



#import "AppBridge.h"
#import "AppDevice.h"
#import "AppEnvironment.h"
#import "GTSettings.h"
#import "Lifecycle.h"
#import "LifecycleManager.h"
#import "LifecycleWrapper.h"
#import "Result.h"

#import "GT_Klasse.h"
#import "GT_PlanList.h"
#import "Model.h"

#import "GT_Plan.h"
#import "GT_PlanEntry.h"
#import "GT_Settings.h"

#import "DAOWrapper.h"
#import "GT_PlanDAOJSON.h"
#import "GT_PlanDAONetwork.h"
#import "GT_SettingsDAOJSON.h"
#import "ModelDAO.h"

#import "Condition.h"
#import "Limit.h"
#import "Query.h"

#import "PlanListJSONMarshaller.h"
#import "SettingsJSONMarshaller.h"

#import "AppService.h"

#import "AppDebugger.h"
#import "Marshaller.h"
#import "Reachability.h"
#import "Unmarshaller.h"

#import "ModelView.h"
#import "PlanListView.h"
