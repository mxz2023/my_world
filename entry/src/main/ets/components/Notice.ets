/**
 * Copyright (c) 2023-2024 Mxz Co., Ltd.
 *
 * @file Notice.ets
 * @project TimeImprint
 * @author vincent_gemini
 * @crateTime 2025-01-04
 * @desc
 */
import { ColorConstants } from "@mxz/component"

@Component
export struct Notice {
  @State fontColor: string = ColorConstants.Gray

  build() {
    Column() {
      Text('温馨提示')
        .fontColor(this.fontColor)
        .fontSize(12)
        .margin({
          top: 7
        })
      Text('出于隐私保护，目前所有打卡记录只保留在本地')
        .fontColor(this.fontColor)
        .fontSize(12)
        .margin({
          top: 7
        })
      Text('卸载应用后，所有数据将无法恢复')
        .fontColor(this.fontColor)
        .fontSize(12)
        .margin({
          top: 7,
          bottom: 7
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}