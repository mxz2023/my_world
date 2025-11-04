import { bundleManager } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

import { CommonDefine } from '@mxz/component';
import { HealthOverview } from '@mxz/fitness';
import { logger } from '@mxz/logger'

const TAG = "Index"

@Entry
@ComponentV2
struct Index {
  @Local appName: ResourceStr = ""
  private pathStack: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    AppStorage.setOrCreate(CommonDefine.globalPathStackName, this.pathStack);

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
            default : {
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
    Navigation(this.pathStack) {
      HealthOverview()
    }
    .title(this.appName)
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .hideBackButton(true)
    .width('100%')
    .height('100%')
  }
}