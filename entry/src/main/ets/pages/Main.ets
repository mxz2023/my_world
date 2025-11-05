/**
 * Copyright (c) 2023-2025 Mxz Co., Ltd.
 *
 * @file Main.ets
 * @project MyWorld
 * @author vincent_gemini
 * @crateTime 2025-11-06
 * @desc
 */

import { AppConstants, NavigationTitleBuilder} from "@mxz/component"
import { HealthOverview } from "@mxz/fitness";
import { router } from "@mxz/router";


@ComponentV2
struct Main {
  private pageInfos: NavPathStack = router.getNavStack();

  build() {
    NavDestination() {
      Column() {
        HealthOverview()
      }
      .height('100%')
      .width('100%')
    }
    .title(NavigationTitleBuilder(this.pageInfos, {
      canBack: false,
      title: {
        text: "叶记健康",
        fontSize: 28,
        fontWeight: FontWeight.Medium
      },
      height: AppConstants.NAV_HEIGHT
    }))
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }
}


@Builder
export function PageBuilder(_: string, __: Object) {
  Main()
}