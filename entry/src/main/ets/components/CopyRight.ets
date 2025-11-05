/**
 * Copyright (c) 2023-2024 Mxz Co., Ltd.
 *
 * @file CopyRight.ets
 * @project TimeImprint
 * @author vincent_gemini
 * @crateTime 2024-11-22
 * @desc
 */
import { ColorConstants } from "@mxz/component"


@Component
export struct CopyRight {

  @State fontColor:string = ColorConstants.Gray

  build() {
    Column() {
      Text('ICP备案号: 津ICP备2024021043号-3A')
        .fontColor(this.fontColor)
        .fontSize(12)
        .margin({
          top: 7
        })
      Text('Copyright © 2024-2025')
        .fontColor(this.fontColor)
        .fontSize(12)
        .margin({
          top: 7
        })
      // Text('天津市武清区叶记时光软件开发工作室')
      //   .fontColor(this.fontColor)
      //   .fontSize(12)
      //   .margin({
      //     top: 7
      //   })
    }
  }
}