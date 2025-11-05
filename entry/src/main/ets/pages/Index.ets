import { bundleManager } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

import { router } from '@mxz/router'
import { logger } from '@mxz/common'

const TAG = "Index"

@Entry
@ComponentV2
struct Index {
  @Local appName: ResourceStr = ""
  private pageInfos: NavPathStack = router.getNavStack();

  aboutToAppear(): void {
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT;
    try {
      bundleManager.getBundleInfoForSelf(bundleFlags)
        .then((data) => {
          logger.debug(TAG, 'BundleName:', data.name);
          switch (data.name) {
            case 'cn.net.mxz.myworld': {
              this.appName = $r('app.string.app_name')
              break
            }
            case 'cn.net.mxz.timeimprint': {
              this.appName = $r('app.string.app_timeimprint')
              break
            }
            case 'cn.net.mxz.fitness': {
              this.appName = $r('app.string.app_fitness')
              break
            }
            case 'cn.net.mxz.qrcode': {
              this.appName = $r('app.string.app_qrcode')
              break
            }
            default: {
              this.appName = $r('app.string.app_name')
            }
          }
        })
        .catch((err: BusinessError) => {
          logger.error(TAG, 'Failed. Cause:' + err.message);
        });
    } catch (err) {
      logger.error(TAG, 'Error:' + (err as BusinessError).message);
    }
  }

  build() {
    Navigation(this.pageInfos) {

    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .hideToolBar(true)
    .height('100%')
    .width('100%')
    .onAppear(() => {
      this.pageInfos.replacePathByName('welcome', null)
    })
  }
}