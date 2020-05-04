# Building your layout from source

Congratulations on taking the next step, and making use of your keyboard's open-source nature! There's so much power to unlock — this is going to be fun. :)

Here are some initial pointers to get you started:

- Use the documentation at [https://docs.qmk.fm/](https://docs.qmk.fm/) to set up your environment for building your firmware.
- Build your layout against [https://github.com/zsa/qmk_firmware/](https://github.com/zsa/qmk_firmware/) which is our QMK fork (instead of qmk/qmk_firmware). This is what Oryx (the graphical configurator) uses, so it's guaranteed to work.
- Create a folder with a simple name (no spaces!) for your layout inside the qmk_firmware/keyboards/ergodox_ez/keymaps/ folder.
- Copy the contents of the \*\_source folder (in the .zip you downloaded from Oryx) into this folder.
- Make sure you've set up your environment per the [QMK docs](https://docs.qmk.fm/#/newbs_getting_started?id=set-up-your-environment) so compilation would actually work.
- From your shell, make sure your working directory is qmk*firmware, then enter the command `make ergodox_ez:_layout_`, substituting the name of the folder you created for "_layout_".

Good luck on your journey! And remember, if you get stuck, you can always get back to your [original layout](https://configure.ergodox-ez.com/ergodox-ez/layouts/m50yq/APxee/0) from Oryx.
