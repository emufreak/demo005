#include "support/amiga.h"
#include "support/gcc8_c.h"

#include "effect1.h"

void eff1_run()
{
    KPrintF("Effect001 started!\n");

    // effect001_initDisplay();

    while(1) {
        WaitVbl();
        KPrintF("Effect001 loop!\n");
    }
}