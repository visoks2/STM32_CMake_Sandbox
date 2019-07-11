# STM32_CMake_Sandbox
Got bored of installing all required software/compilers/buildtools/..... each time i clean/reset windows, so tried to created a project where i don't need to do that.
Also learning how to program stm32 chips with C++

How to use it (windows): 
  1) get visual studio code (https://code.visualstudio.com/) and install these extensions:
        https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools
        https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug
  2) build it! open vscode and run task (ctrl+shift+b) or Terminal->Run Task...->(choose any from popup)
      tasks are defined in ./.vscode/tasks.json
  3) install st-link/v2 drivers from:
        https://www.st.com/en/development-tools/stsw-link009.html or
        ./_sandbox/_drivers/
  4) connect your shit (optional if you for some reason want only to build project :D)
  5) flash it! (same as #2)
  
How to use it (Linux): 
  possible TODO. notify me if you implemented this or are interested in it! ^_^
  
What i use:
  1) ST-Link V2 STM8/STM32 
  3) STM32F103C8 board aka Blue Pill
