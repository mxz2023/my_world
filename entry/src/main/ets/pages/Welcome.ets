/**
 * Copyright (c) 2023-2024 Mxz Co., Ltd.
 *
 * @file Welcome.ets
 * @project TimeImprint
 * @author vincent_gemini
 * @crateTime 2024-10-25
 * @desc
 */

import { common, Want } from '@kit.AbilityKit';

import { WindowUtil } from '@mxz/common';
import { AppConstants, ColorConstants } from '@mxz/component';
import { router } from '@mxz/router';

// inner
import { CopyRight } from '../components/CopyRight';
import { PrivacyDialog } from '../components/PrivacyDialog';


const TAG = 'Welcome.ets'

@Component
struct Welcome {
  private pageInfos: NavPathStack = router.getNavStack();
  privacyDialogController: CustomDialogController = new CustomDialogController({
    builder: PrivacyDialog({
      isShowExit: false,
      agree: async () => {
        this.agreedPrivacy()
      },
      unAgree: () => {
        // 挽留弹窗
        if (this.privacyExitDialogController != undefined) {
          this.privacyExitDialogController.open();
        } else {
          this.closeApp()
        }
      },
      privacyLink: () => {
        // 打开隐私页面
        this.openSystemWebView('https://www.mxz.net.cn/privacy/')
      }
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true,
    autoCancel: false,
    offset: { dx: 0, dy: 0 },
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
    }
  })
  // 隐私协议退出弹窗
  privacyExitDialogController: CustomDialogController = new CustomDialogController({
    builder: PrivacyDialog({
      isShowExit: true,
      agree: async () => {
        this.agreedPrivacy()
      },
      unAgree: () => {
        // 关闭应用
        this.closeApp()
      },
      privacyLink: () => {
        this.openSystemWebView('https://www.mxz.net.cn/privacy/')
      }
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true,
    autoCancel: false,
    offset: { dx: 0, dy: 0 },
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {

    }
  })

  build() {
    NavDestination() {
      Column() {
        Image($r("app.media.logo_icon_fitness"))
          .width('320')
          .height('320')
          .margin({
            top: AppConstants.NAV_HEIGHT
          })

        Column() {
          Row() {
            Image($r("app.media.logo_icon_fitness"))
              .width('28')
              .height('28')
            Image($r('app.media.logo_name_fitness'))
              .width('123')
              .height('28')
          }

          CopyRight({
            fontColor: ColorConstants.White
          }).margin({
            top: AppConstants.VIEW_MARGIN
          })
        }
        .margin({
          bottom: AppConstants.NAV_INDICATOR_HEIGHT
        })
      }
      .height('100%')
      .width('100%')
      .padding(AppConstants.VIEW_MARGIN)
      .backgroundColor(ColorConstants.Yellow)
      .justifyContent(FlexAlign.SpaceBetween)
      .onAppear(() => {
        setTimeout(() => {
          this.handleAgreement()
        }, 1000)
      })
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }

  /**
   * 处理隐私
   */
  private handleAgreement() {
    this.openApp()
    // todo
    // UserManger.getInstance().isAgreement().then((hasAgreement) => {
    //   if (hasAgreement) {
    //     this.openApp()
    //   } else {
    //     // 隐私协议弹窗
    //     this.privacyDialogController.open()
    //   }
    // })
  }

  /**
   *
   * @param targetUrl
   */
  private openSystemWebView(targetUrl: string) {
    let wantInfo: Want = {
      action: 'ohos.want.action.viewData',
      entities: ['entity.system.browsable'],
      uri: targetUrl
    }
    try {
      (this.getUIContext().getHostContext() as common.UIAbilityContext).startAbility(wantInfo).catch(() => {
        // TODO: Implement error handling.
      })
    } catch (e) {

    }
  }

  /**
   *
   */
  private agreedPrivacy() {
    // todo
    // UserManger.getInstance().setAgreementState(true)
    this.openApp()
  }

  /**
   * 关闭APP
   */
  private closeApp() {
    (this.getUIContext().getHostContext() as common.UIAbilityContext).terminateSelf().catch(() => {
      // TODO: Implement error handling.
    })
  }

  /**
   * 进入应用
   */
  private openApp() {
    this.pageInfos.replacePathByName('main', null)
  }
}

@Builder
export function PageBuilder(_: string, __: Object) {
  Welcome()
}