/**
 * Copyright (c) 2023-2024 Mxz Co., Ltd.
 *
 * @file PrivacyDialog.ets
 * @project TimeImprint
 * @author vincent_gemini
 * @crateTime 2024-12-09
 * @desc
 */
import { AppConstants, ColorConstants } from "@mxz/component";

@CustomDialog
export struct PrivacyDialog {
  controller: CustomDialogController;
  unAgree: Function = () => {
  };
  agree: Function = () => {
  };
  privacyLink: Function = () => {
  };
  @State isShowExit: boolean = false

  build() {
    Column() {
      Text('叶记时光隐私政策')
        .fontColor(ColorConstants.Black)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .height(52)
      Line()
        .height(1)
        .width('100%')
        .backgroundColor(ColorConstants.Black)
        .opacity(0.06)
      if (this.isShowExit) {
        Text() {
          Span('我们非常重视对您的个人信息的保护，承诺严格按照叶记时光隐私政策保护及处理您的信息，如您不同意')
            .fontColor('#666666')
            .fontSize(16)
          Span('《叶记时光隐私政策》')
            .fontColor(ColorConstants.Red)
            .fontSize(16)
            .onClick(() => {
              this.privacyLink()
            })
          Span('，很遗憾我们将无法提供服务。')
            .fontColor('#666666')
            .fontSize(16)
        }
        .margin({
          top: 12
        })
        .padding({
          left: 20,
          right: 20
        })
      } else {
        Text() {
          Span('请在使用前仔细阅读')
            .fontColor('#666666')
            .fontSize(16)
          Span('《叶记时光隐私政策》')
            .fontColor(ColorConstants.Red)
            .fontSize(16)
            .onClick(() => {
              this.privacyLink()
            })
          Span('，并理解相关条款。我们会不断完善技术和安全管理，保护您的个人信息，点击“同意并进入”按钮代表您已同意前述协议。')
            .fontColor('#666666')
            .fontSize(16)
        }
        .margin({
          top: 12
        })
        .padding({
          left: 20,
          right: 20
        })
      }

      Column() {
        Button({
          type: ButtonType.Normal,
        }) {
          Text('同意并进入')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .focusable(true)
            .focusOnTouch(true)
        }
        .width('100%')
        .height(AppConstants.BTN_HEIGHT)
        .borderRadius(AppConstants.BTN_HEIGHT)
        .onClick(() => {
          this.controller.close()
          this.agree()
        })
        .backgroundColor(ColorConstants.Red)
        .defaultFocus(true)
        .focusOnTouch(true)

        Button({
          type: ButtonType.Normal,
        }) {
          Text(this.isShowExit ? '退出应用' : '不同意')
            .fontColor('#666666')
            .fontSize(16)
            .focusable(true)
            .focusOnTouch(true)
        }
        .margin({
          top: 16
        })
        .height(24)
        .onClick(() => {
          this.controller.close()
          this.unAgree()
        })
        .backgroundColor(Color.Transparent)
        .defaultFocus(true)
        .focusOnTouch(true)
        .stateEffect(false)
      }
      .margin({
        top: 32
      })
      .padding({
        left: 30,
        right: 30
      })
    }
    .padding({
      bottom: 32
    })
    .width('100%')
    .borderRadius({
      topLeft: 8,
      topRight: 8
    })
    .backgroundColor(Color.White)
    .transition(TransitionEffect.OPACITY
      .animation({ duration: 300 })
      .combine(TransitionEffect.translate({ y: 300 })))
  }
}