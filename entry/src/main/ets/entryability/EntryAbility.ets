import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

import { GlobalContext, logger, WindowUtil} from '@mxz/common'

const TAG = 'EntryAbility'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      logger.error(TAG, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    logger.info(TAG, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    logger.info(TAG, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    logger.info(TAG, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    GlobalContext.setWindowStage(windowStage)
    GlobalContext.setUIAbilityContext(this.context)
    GlobalContext.setApplicationContext(this.context.getApplicationContext())

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        logger.error(TAG, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      logger.info(TAG, 'testTag', 'Succeeded in loading the content.');

      // 设置全屏
      WindowUtil.requestFullScreen(windowStage, this.context);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    logger.info(TAG, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    logger.info(TAG, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    logger.info(TAG, 'testTag', '%{public}s', 'Ability onBackground');
  }
}