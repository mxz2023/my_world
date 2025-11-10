/**
 * Copyright (c) 2023-2025 Mxz Co., Ltd.
 *
 * @file Main.ets
 * @project MyWorld
 * @author vincent_gemini
 * @crateTime 2025-11-06
 * @desc
 */

import { AppConstants, ColorConstants, MIcon, NavigationTitleBuilder } from "@mxz/component"
import { HealthPage } from "@mxz/fitness";
import { router, TabIndex, TabManager } from "@mxz/router";
import { AppStorageV2 } from "@kit.ArkUI";


@ObservedV2
class MainTabInfo {
  @Trace index: number = 0
}

export class MainTabManager extends TabManager {
  changeToIndex(index: number) {
    super.changeToIndex(index)
    const curTabInfo = AppStorageV2.connect<MainTabInfo>(MainTabInfo, () => new MainTabInfo())
    if (curTabInfo) {
      curTabInfo.index = index
    }
  }
}

@ComponentV2
struct Main {
  private pageInfos: NavPathStack = router.getNavStack();
  private controller: TabsController = new TabsController()
  private tabManager: MainTabManager = new MainTabManager()
  private isQuite: boolean = false // 是否退出
  @Local curTabInfo: MainTabInfo = AppStorageV2.connect<MainTabInfo>(MainTabInfo, () => new MainTabInfo())!

  aboutToAppear(): void {

  }

  aboutToDisappear(): void {

  }

  onPageShow(): void {
    this.tabManager.showPage()
  }

  onPageHide(): void {
    this.tabManager.hidePage()
  }

  @Builder
  tabBuilder(title: string | Resource, icon: string, targetIndex: number) {
    Column() {
      if (this.curTabInfo.index == targetIndex) {
        MIcon({
          iconName: icon,
          iconColor: [ColorConstants.Red],
          iconSize: 25,
        })
      } else {
        MIcon({
          iconName: icon,
          iconColor: [ColorConstants.Gray],
          iconSize: 25,
        })
      }

      Text(title)
        .fontColor(this.curTabInfo.index === targetIndex ? ColorConstants.Red : ColorConstants.Black)
        .fontSize(12)
        .margin({ top: 5 })
    }
    .backgroundColor(ColorConstants.White)
    .width('100%')
    .height(AppConstants.TAB_BAR_BOTTOM_SAVE_HEIGHT + AppConstants.TAB_BAR_HEIGHT)
    .padding(10)
    .justifyContent(FlexAlign.Start)
  }

  build() {
    NavDestination() {
      Tabs({
        barPosition: BarPosition.End,
        controller: this.controller,
        index: this.curTabInfo.index
      }) {
        TabContent() {
          HealthPage().layoutWeight(1)
        }.tabBar(this.tabBuilder("首页", 'home', TabIndex.TabHome))

        TabContent() {
          Row() {
            Text("开发中")
          }
        }.tabBar(this.tabBuilder("我的", 'mine', TabIndex.TabRecord))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .barHeight(80)
      .animationDuration(0)
      .onChange((index: number) => {
        this.tabManager.changeToIndex(index)
      })
      .width('100%')
      .height('100%')
      .scrollable(false)
    }
    // .title({
    //   builder: NavigationTitleBuilder(this.pageInfos, {
    //     canBack: false,
    //     title: {
    //       text: "叶记健康",
    //       fontSize: 28,
    //       fontWeight: FontWeight.Medium
    //     },
    //   }),
    //   height: AppConstants.NAV_HEIGHT
    // })
    .hideTitleBar(true)
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