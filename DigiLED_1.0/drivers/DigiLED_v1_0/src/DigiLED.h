
#ifndef DIGILED_H
#define DIGILED_H

/***********************************************************************

    DigiLED V1.0

    Simple drivers to control the DigiLED IP block

    Written by Marshall Wingerson
        
***********************************************************************/

/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"
#include <stdio.h>
#include <stdlib.h>
#include "xparameters.h"
#include "xgpio.h"
#include "xil_types.h"

#define DIGILED_S00_AXI_SLV_REG0_OFFSET 0
#define DIGILED_S00_AXI_SLV_REG1_OFFSET 4
#define DIGILED_S00_AXI_SLV_REG2_OFFSET 8
#define DIGILED_S00_AXI_SLV_REG3_OFFSET 12

/**************************** Type Definitions *****************************/

void enable_LEDs(void);

void disable_LEDs(void);

void SetLEDColor(int led, uint16_t hue, uint8_t sat, uint8_t val);

void clearLEDs(int led_num);

#endif // DIGILED_H
