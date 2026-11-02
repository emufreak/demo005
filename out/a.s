
out/a.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
   0:	       movem.l d2-d3/a2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
	for (i = 0; i < count; i++)
   4:	       move.l #10200,d0
   a:	       cmpi.l #10200,d0
  10:	,----- beq.s 2e <_start+0x2e>
	count = __preinit_array_end - __preinit_array_start;
  12:	|      move.l d0,d3
  14:	|      subi.l #10200,d3
  1a:	|      asr.l #2,d3
  1c:	|      lea 27d8 <ActiView>,a2
	for (i = 0; i < count; i++)
  22:	|      moveq #0,d2
		__preinit_array_start[i]();
  24:	|  ,-> movea.l (a2)+,a0
  26:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  28:	|  |   addq.l #1,d2
  2a:	|  |   cmp.l d3,d2
  2c:	|  '-- bcs.s 24 <_start+0x24>

	count = __init_array_end - __init_array_start;
	for (i = 0; i < count; i++)
  2e:	'----> move.l #10200,d0
  34:	       cmpi.l #10200,d0
  3a:	,----- beq.s 58 <_start+0x58>
	count = __init_array_end - __init_array_start;
  3c:	|      move.l d0,d3
  3e:	|      subi.l #10200,d3
  44:	|      asr.l #2,d3
  46:	|      lea 27d8 <ActiView>,a2
	for (i = 0; i < count; i++)
  4c:	|      moveq #0,d2
		__init_array_start[i]();
  4e:	|  ,-> movea.l (a2)+,a0
  50:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  52:	|  |   addq.l #1,d2
  54:	|  |   cmp.l d3,d2
  56:	|  '-- bcs.s 4e <_start+0x4e>

	main();
  58:	'----> jsr 5e <main>

0000005e <main>:
static void Wait10() { WaitLine(0x10); }
static void Wait11() { WaitLine(0x11); }
static void Wait12() { WaitLine(0x12); }
static void Wait13() { WaitLine(0x13); }

int main() {
  5e:	                   movem.l d2-d3/d7/a2-a3/a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
  62:	                   movea.l 4 <_start+0x4>,a6
  66:	                   move.l a6,27f2 <SysBase>
	custom = (struct Custom*)0xdff000;
  6c:	                   move.l #14675968,27f8 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR)"graphics.library",0);
  76:	                   lea 753 <PutChar+0xcd>,a1
  7c:	                   moveq #0,d0
  7e:	                   jsr -552(a6)
  82:	                   move.l d0,27ee <GfxBase>
	if (!GfxBase)
  88:	      ,----------- beq.w 31a <main+0x2bc>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  8c:	      |            movea.l 27f2 <SysBase>,a6
  92:	      |            lea 764 <PutChar+0xde>,a1
  98:	      |            moveq #0,d0
  9a:	      |            jsr -552(a6)
  9e:	      |            move.l d0,27ea <DOSBase>
	if (!DOSBase)
  a4:	,-----|----------- beq.w 22a <main+0x1cc>
		Exit(0);

	KPrintF("Hello debugger from Amiga!\n");
  a8:	|  ,--|----------> pea 770 <PutChar+0xea>
  ae:	|  |  |            lea 3c6 <KPrintF>,a3
  b4:	|  |  |            jsr (a3)

	Write(Output(), (APTR)"Hello console!\n", 15);
  b6:	|  |  |            movea.l 27ea <DOSBase>,a6
  bc:	|  |  |            jsr -60(a6)
  c0:	|  |  |            movea.l 27ea <DOSBase>,a6
  c6:	|  |  |            move.l d0,d1
  c8:	|  |  |            move.l #1932,d2
  ce:	|  |  |            moveq #15,d3
  d0:	|  |  |            jsr -48(a6)
	Delay(50);
  d4:	|  |  |            movea.l 27ea <DOSBase>,a6
  da:	|  |  |            moveq #50,d1
  dc:	|  |  |            jsr -198(a6)

	warpmode(1);
  e0:	|  |  |            pea 1 <_start+0x1>
  e4:	|  |  |            lea 438 <warpmode>,a2
  ea:	|  |  |            jsr (a2)
	// TODO: precalc stuff here

    warpmode(0);
  ec:	|  |  |            clr.l -(sp)
  ee:	|  |  |            jsr (a2)
	Forbid();
  f0:	|  |  |            movea.l 27f2 <SysBase>,a6
  f6:	|  |  |            jsr -132(a6)
	SystemADKCON=custom->adkconr;
  fa:	|  |  |            movea.l 27f8 <custom>,a0
 100:	|  |  |            move.w 16(a0),d0
 104:	|  |  |            move.w d0,27dc <SystemADKCON>
	SystemInts=custom->intenar;
 10a:	|  |  |            move.w 28(a0),d0
 10e:	|  |  |            move.w d0,27e0 <SystemInts>
	SystemDMA=custom->dmaconr;
 114:	|  |  |            move.w 2(a0),d0
 118:	|  |  |            move.w d0,27de <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
 11e:	|  |  |            movea.l 27ee <GfxBase>,a6
 124:	|  |  |            move.l 34(a6),27d8 <ActiView>
	LoadView(0);
 12c:	|  |  |            suba.l a1,a1
 12e:	|  |  |            jsr -222(a6)
	WaitTOF();
 132:	|  |  |            movea.l 27ee <GfxBase>,a6
 138:	|  |  |            jsr -270(a6)
	WaitTOF();
 13c:	|  |  |            movea.l 27ee <GfxBase>,a6
 142:	|  |  |            jsr -270(a6)
	WaitVbl();
 146:	|  |  |            lea 5a2 <WaitVbl>,a2
 14c:	|  |  |            jsr (a2)
	WaitVbl();
 14e:	|  |  |            jsr (a2)
	OwnBlitter();
 150:	|  |  |            movea.l 27ee <GfxBase>,a6
 156:	|  |  |            jsr -456(a6)
	WaitBlit();
 15a:	|  |  |            movea.l 27ee <GfxBase>,a6
 160:	|  |  |            jsr -228(a6)
	Disable();
 164:	|  |  |            movea.l 27f2 <SysBase>,a6
 16a:	|  |  |            jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
 16e:	|  |  |            movea.l 27f8 <custom>,a0
 174:	|  |  |            move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 17a:	|  |  |            move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 180:	|  |  |            move.w #32767,150(a0)
 186:	|  |  |            lea 12(sp),sp
	for(int a=0;a<32;a++)
 18a:	|  |  |            moveq #0,d1
		custom->color[a]=0;
 18c:	|  |  |     ,----> move.l d1,d0
 18e:	|  |  |     |      addi.l #192,d0
 194:	|  |  |     |      add.l d0,d0
 196:	|  |  |     |      move.w #0,(0,a0,d0.l)
	for(int a=0;a<32;a++)
 19c:	|  |  |     |      addq.l #1,d1
 19e:	|  |  |     |      moveq #32,d0
 1a0:	|  |  |     |      cmp.l d1,d0
 1a2:	|  |  |     +----- bne.s 18c <main+0x12e>
	WaitVbl();
 1a4:	|  |  |     |      jsr (a2)
	WaitVbl();
 1a6:	|  |  |     |      jsr (a2)
	if (SysBase->AttnFlags & AFF_68010)
 1a8:	|  |  |     |      movea.l 27f2 <SysBase>,a6
 1ae:	|  |  |     |      btst #0,297(a6)
 1b4:	|  |  |  ,--|----- beq.w 346 <main+0x2e8>
		vbr = (APTR)Supervisor((ULONG (*)())SupervisorGetVBR);
 1b8:	|  |  |  |  |      move.l #918,d7
 1be:	|  |  |  |  |      exg d7,a5
 1c0:	|  |  |  |  |      jsr -30(a6)
 1c4:	|  |  |  |  |      exg d7,a5
	VBR=GetVBR();
 1c6:	|  |  |  |  |      move.l d0,27e6 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
 1cc:	|  |  |  |  |      movea.l 27e6 <VBR>,a0
 1d2:	|  |  |  |  |      move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
 1d6:	|  |  |  |  |      move.l d0,27e2 <SystemIrq>

	TakeSystem();
	WaitVbl();
 1dc:	|  |  |  |  |      jsr (a2)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
 1de:	|  |  |  |  |      movea.l 27e6 <VBR>,a0
 1e4:	|  |  |  |  |      move.l #924,108(a0)
	// DEMO
	SetInterruptHandler((APTR)interruptHandler);
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
 1ec:	|  |  |  |  |      movea.l 27f8 <custom>,a0
 1f2:	|  |  |  |  |      move.w #-16352,154(a0)

	custom->intreq=(1<<INTB_VERTB);//reset vbl req
 1f8:	|  |  |  |  |      move.w #32,156(a0)

#include "controlDemo.h"
#include "effect1.h"

void controlDemo() {
    KPrintF("Control Demo started!\n");
 1fe:	|  |  |  |  |      pea 79c <PutChar+0x116>
 204:	|  |  |  |  |      jsr (a3)

#include "effect1.h"

void eff1_run()
{
    KPrintF("Effect001 started!\n");
 206:	|  |  |  |  |      pea 7b3 <PutChar+0x12d>
 20c:	|  |  |  |  |      jsr (a3)
 20e:	|  |  |  |  |      addq.l #8,sp

    // effect001_initDisplay();

    while(1) {
        WaitVbl();
 210:	|  |  |  |  |  ,-> jsr (a2)
        KPrintF("Effect001 loop!\n");
 212:	|  |  |  |  |  |   pea 7c7 <PutChar+0x141>
 218:	|  |  |  |  |  |   jsr (a3)
 21a:	|  |  |  |  |  |   addq.l #4,sp
        WaitVbl();
 21c:	|  |  |  |  |  |   jsr (a2)
        KPrintF("Effect001 loop!\n");
 21e:	|  |  |  |  |  |   pea 7c7 <PutChar+0x141>
 224:	|  |  |  |  |  |   jsr (a3)
 226:	|  |  |  |  |  |   addq.l #4,sp
 228:	|  |  |  |  |  +-- bra.s 210 <main+0x1b2>
		Exit(0);
 22a:	>--|--|--|--|--|-> suba.l a6,a6
 22c:	|  |  |  |  |  |   moveq #0,d1
 22e:	|  |  |  |  |  |   jsr -144(a6)
	KPrintF("Hello debugger from Amiga!\n");
 232:	|  |  |  |  |  |   pea 770 <PutChar+0xea>
 238:	|  |  |  |  |  |   lea 3c6 <KPrintF>,a3
 23e:	|  |  |  |  |  |   jsr (a3)
	Write(Output(), (APTR)"Hello console!\n", 15);
 240:	|  |  |  |  |  |   movea.l 27ea <DOSBase>,a6
 246:	|  |  |  |  |  |   jsr -60(a6)
 24a:	|  |  |  |  |  |   movea.l 27ea <DOSBase>,a6
 250:	|  |  |  |  |  |   move.l d0,d1
 252:	|  |  |  |  |  |   move.l #1932,d2
 258:	|  |  |  |  |  |   moveq #15,d3
 25a:	|  |  |  |  |  |   jsr -48(a6)
	Delay(50);
 25e:	|  |  |  |  |  |   movea.l 27ea <DOSBase>,a6
 264:	|  |  |  |  |  |   moveq #50,d1
 266:	|  |  |  |  |  |   jsr -198(a6)
	warpmode(1);
 26a:	|  |  |  |  |  |   pea 1 <_start+0x1>
 26e:	|  |  |  |  |  |   lea 438 <warpmode>,a2
 274:	|  |  |  |  |  |   jsr (a2)
    warpmode(0);
 276:	|  |  |  |  |  |   clr.l -(sp)
 278:	|  |  |  |  |  |   jsr (a2)
	Forbid();
 27a:	|  |  |  |  |  |   movea.l 27f2 <SysBase>,a6
 280:	|  |  |  |  |  |   jsr -132(a6)
	SystemADKCON=custom->adkconr;
 284:	|  |  |  |  |  |   movea.l 27f8 <custom>,a0
 28a:	|  |  |  |  |  |   move.w 16(a0),d0
 28e:	|  |  |  |  |  |   move.w d0,27dc <SystemADKCON>
	SystemInts=custom->intenar;
 294:	|  |  |  |  |  |   move.w 28(a0),d0
 298:	|  |  |  |  |  |   move.w d0,27e0 <SystemInts>
	SystemDMA=custom->dmaconr;
 29e:	|  |  |  |  |  |   move.w 2(a0),d0
 2a2:	|  |  |  |  |  |   move.w d0,27de <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
 2a8:	|  |  |  |  |  |   movea.l 27ee <GfxBase>,a6
 2ae:	|  |  |  |  |  |   move.l 34(a6),27d8 <ActiView>
	LoadView(0);
 2b6:	|  |  |  |  |  |   suba.l a1,a1
 2b8:	|  |  |  |  |  |   jsr -222(a6)
	WaitTOF();
 2bc:	|  |  |  |  |  |   movea.l 27ee <GfxBase>,a6
 2c2:	|  |  |  |  |  |   jsr -270(a6)
	WaitTOF();
 2c6:	|  |  |  |  |  |   movea.l 27ee <GfxBase>,a6
 2cc:	|  |  |  |  |  |   jsr -270(a6)
	WaitVbl();
 2d0:	|  |  |  |  |  |   lea 5a2 <WaitVbl>,a2
 2d6:	|  |  |  |  |  |   jsr (a2)
	WaitVbl();
 2d8:	|  |  |  |  |  |   jsr (a2)
	OwnBlitter();
 2da:	|  |  |  |  |  |   movea.l 27ee <GfxBase>,a6
 2e0:	|  |  |  |  |  |   jsr -456(a6)
	WaitBlit();
 2e4:	|  |  |  |  |  |   movea.l 27ee <GfxBase>,a6
 2ea:	|  |  |  |  |  |   jsr -228(a6)
	Disable();
 2ee:	|  |  |  |  |  |   movea.l 27f2 <SysBase>,a6
 2f4:	|  |  |  |  |  |   jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
 2f8:	|  |  |  |  |  |   movea.l 27f8 <custom>,a0
 2fe:	|  |  |  |  |  |   move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 304:	|  |  |  |  |  |   move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 30a:	|  |  |  |  |  |   move.w #32767,150(a0)
 310:	|  |  |  |  |  |   lea 12(sp),sp
	for(int a=0;a<32;a++)
 314:	|  |  |  |  |  |   moveq #0,d1
 316:	|  |  |  |  '--|-- bra.w 18c <main+0x12e>
		Exit(0);
 31a:	|  |  '--|-----|-> movea.l 27ea <DOSBase>,a6
 320:	|  |     |     |   moveq #0,d1
 322:	|  |     |     |   jsr -144(a6)
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
 326:	|  |     |     |   movea.l 27f2 <SysBase>,a6
 32c:	|  |     |     |   lea 764 <PutChar+0xde>,a1
 332:	|  |     |     |   moveq #0,d0
 334:	|  |     |     |   jsr -552(a6)
 338:	|  |     |     |   move.l d0,27ea <DOSBase>
	if (!DOSBase)
 33e:	|  '-----|-----|-- bne.w a8 <main+0x4a>
 342:	'--------|-----|-- bra.w 22a <main+0x1cc>
	APTR vbr = 0;
 346:	         '-----|-> moveq #0,d0
	VBR=GetVBR();
 348:	               |   move.l d0,27e6 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
 34e:	               |   movea.l 27e6 <VBR>,a0
 354:	               |   move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
 358:	               |   move.l d0,27e2 <SystemIrq>
	WaitVbl();
 35e:	               |   jsr (a2)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
 360:	               |   movea.l 27e6 <VBR>,a0
 366:	               |   move.l #924,108(a0)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
 36e:	               |   movea.l 27f8 <custom>,a0
 374:	               |   move.w #-16352,154(a0)
	custom->intreq=(1<<INTB_VERTB);//reset vbl req
 37a:	               |   move.w #32,156(a0)
 380:	               |   pea 79c <PutChar+0x116>
 386:	               |   jsr (a3)
    KPrintF("Effect001 started!\n");
 388:	               |   pea 7b3 <PutChar+0x12d>
 38e:	               |   jsr (a3)
 390:	               |   addq.l #8,sp
 392:	               '-- bra.w 210 <main+0x1b2>

00000396 <SupervisorGetVBR>:
	__asm__ volatile(".short 0x4e7a, 0x0801"); // movec.l vbr, d0
 396:	.short 0x4e7a
 398:	btst #115,d1

0000039c <interruptHandler>:
static __attribute__((interrupt)) void interruptHandler() {
 39c:	move.l a0,-(sp)
 39e:	move.l d0,-(sp)
	custom->intreq=(1<<INTB_VERTB); custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.
 3a0:	movea.l 27f8 <custom>,a0
 3a6:	move.w #32,156(a0)
 3ac:	move.w #32,156(a0)
	frameCounter++;
 3b2:	move.w 27f6 <frameCounter>,d0
 3b8:	addq.w #1,d0
 3ba:	move.w d0,27f6 <frameCounter>
}
 3c0:	move.l (sp)+,d0
 3c2:	movea.l (sp)+,a0
 3c4:	rte

000003c6 <KPrintF>:
void KPrintF(const char* fmt, ...) {
 3c6:	    lea -128(sp),sp
 3ca:	    movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
 3ce:	    move.w f0ff60 <amiga.c.1d0c19c9+0xf0a27f>,d0
 3d4:	    cmpi.w #20153,d0
 3d8:	,-- beq.s 404 <KPrintF+0x3e>
 3da:	|   cmpi.w #-24562,d0
 3de:	+-- beq.s 404 <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
 3e0:	|   movea.l 27f2 <SysBase>,a6
 3e6:	|   movea.l 144(sp),a0
 3ea:	|   lea 148(sp),a1
 3ee:	|   lea 678 <KPutCharX>,a2
 3f4:	|   suba.l a3,a3
 3f6:	|   jsr -522(a6)
}
 3fa:	|   movem.l (sp)+,a2-a3/a6
 3fe:	|   lea 128(sp),sp
 402:	|   rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
 404:	'-> movea.l 27f2 <SysBase>,a6
 40a:	    movea.l 144(sp),a0
 40e:	    lea 148(sp),a1
 412:	    lea 686 <PutChar>,a2
 418:	    lea 12(sp),a3
 41c:	    jsr -522(a6)
		UaeDbgLog(86, temp);
 420:	    move.l a3,-(sp)
 422:	    pea 56 <_start+0x56>
 426:	    jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
 42c:	    addq.l #8,sp
}
 42e:	    movem.l (sp)+,a2-a3/a6
 432:	    lea 128(sp),sp
 436:	    rts

00000438 <warpmode>:
	count = __fini_array_end - __fini_array_start;
	for (i = count; i > 0; i--)
		__fini_array_start[i - 1]();
}

void warpmode(int on) { // bool
 438:	       subq.l #4,sp
 43a:	       move.l a5,-(sp)
	long(*UaeConf)(long mode, int index, const char* param, int param_len, char* outbuf, int outbuf_len);
	UaeConf = (long(*)(long, int, const char*, int, char*, int))0xf0ff60;
	if(*((UWORD *)UaeConf) == 0x4eb9 || *((UWORD *)UaeConf) == 0xa00e) {
 43c:	       move.w f0ff60 <amiga.c.1d0c19c9+0xf0a27f>,d0
 442:	       cmpi.w #20153,d0
 446:	   ,-- beq.s 454 <warpmode+0x1c>
 448:	   |   cmpi.w #-24562,d0
 44c:	   +-- beq.s 454 <warpmode+0x1c>
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
	}
}
 44e:	   |   movea.l (sp)+,a5
 450:	   |   addq.l #4,sp
 452:	   |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
 454:	   '-> tst.l 12(sp)
 458:	,----- beq.w 500 <warpmode+0xc8>
 45c:	|      pea 1 <_start+0x1>
 460:	|      lea 11(sp),a5
 464:	|      move.l a5,-(sp)
 466:	|      clr.l -(sp)
 468:	|      pea 6f8 <PutChar+0x72>
 46e:	|      pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 472:	|      pea 52 <_start+0x52>
 476:	|      jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
 47c:	|      pea 1 <_start+0x1>
 480:	|      move.l a5,-(sp)
 482:	|      clr.l -(sp)
 484:	|      pea 706 <PutChar+0x80>
 48a:	|      pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 48e:	|      pea 52 <_start+0x52>
 492:	|      jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
 498:	|      lea 48(sp),sp
 49c:	|      pea 1 <_start+0x1>
 4a0:	|      move.l a5,-(sp)
 4a2:	|      clr.l -(sp)
 4a4:	|      pea 71c <PutChar+0x96>
 4aa:	|      pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 4ae:	|      pea 52 <_start+0x52>
 4b2:	|      jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
 4b8:	|      pea 1 <_start+0x1>
 4bc:	|      move.l a5,-(sp)
 4be:	|      clr.l -(sp)
 4c0:	|      pea 739 <PutChar+0xb3>
 4c6:	|      pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 4ca:	|      pea 52 <_start+0x52>
 4ce:	|      jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
 4d4:	|      lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
 4d8:	|      move.l #1674,d0
 4de:	|      pea 1 <_start+0x1>
 4e2:	|      move.l a5,-(sp)
 4e4:	|      clr.l -(sp)
 4e6:	|      move.l d0,-(sp)
 4e8:	|      pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 4ec:	|      pea 52 <_start+0x52>
 4f0:	|      jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
}
 4f6:	|      lea 24(sp),sp
 4fa:	|  ,-> movea.l (sp)+,a5
 4fc:	|  |   addq.l #4,sp
 4fe:	|  |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
 500:	'--|-> pea 1 <_start+0x1>
 504:	   |   lea 11(sp),a5
 508:	   |   move.l a5,-(sp)
 50a:	   |   clr.l -(sp)
 50c:	   |   pea 69f <PutChar+0x19>
 512:	   |   pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 516:	   |   pea 52 <_start+0x52>
 51a:	   |   jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
 520:	   |   pea 1 <_start+0x1>
 524:	   |   move.l a5,-(sp)
 526:	   |   clr.l -(sp)
 528:	   |   pea 6ae <PutChar+0x28>
 52e:	   |   pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 532:	   |   pea 52 <_start+0x52>
 536:	   |   jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
 53c:	   |   lea 48(sp),sp
 540:	   |   pea 1 <_start+0x1>
 544:	   |   move.l a5,-(sp)
 546:	   |   clr.l -(sp)
 548:	   |   pea 6c3 <PutChar+0x3d>
 54e:	   |   pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 552:	   |   pea 52 <_start+0x52>
 556:	   |   jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
 55c:	   |   pea 1 <_start+0x1>
 560:	   |   move.l a5,-(sp)
 562:	   |   clr.l -(sp)
 564:	   |   pea 6df <PutChar+0x59>
 56a:	   |   pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 56e:	   |   pea 52 <_start+0x52>
 572:	   |   jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
 578:	   |   lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
 57c:	   |   move.l #1684,d0
 582:	   |   pea 1 <_start+0x1>
 586:	   |   move.l a5,-(sp)
 588:	   |   clr.l -(sp)
 58a:	   |   move.l d0,-(sp)
 58c:	   |   pea ffffffff <amiga.c.1d0c19c9+0xffffa31e>
 590:	   |   pea 52 <_start+0x52>
 594:	   |   jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
}
 59a:	   |   lea 24(sp),sp
 59e:	   '-- bra.w 4fa <warpmode+0xc2>

000005a2 <WaitVbl>:
#include "gcc8_c.h"
#include "amiga.h"

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl() {
 5a2:	             subq.l #8,sp
 5a4:	             move.l a5,-(sp)

static void debug_cmd(unsigned int arg1, unsigned int arg2, unsigned int arg3, unsigned int arg4) {
	long(*UaeLib)(unsigned int arg0, unsigned int arg1, unsigned int arg2, unsigned int arg3, unsigned int arg4);
	UaeLib = (long(*)(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int))0xf0ff60;
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 5a6:	             move.w f0ff60 <amiga.c.1d0c19c9+0xf0a27f>,d1
 5ac:	             cmpi.w #20153,d1
 5b0:	      ,----- beq.s 630 <WaitVbl+0x8e>
 5b2:	      |      cmpi.w #-24562,d1
 5b6:	      +----- beq.s 630 <WaitVbl+0x8e>
	debug_start_idle();
	while (1) {
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 5b8:	,-----|----> move.l dff004 <amiga.c.1d0c19c9+0xdf9323>,d0
 5be:	|     |      move.l d0,4(sp)
		vpos&=0x1ff00;
 5c2:	|     |      move.l 4(sp),d0
 5c6:	|     |      andi.l #130816,d0
 5cc:	|     |      move.l d0,4(sp)
		if (vpos!=(311<<8))
 5d0:	|     |      move.l 4(sp),d0
 5d4:	|     |      cmpi.l #79616,d0
 5da:	+-----|----- beq.s 5b8 <WaitVbl+0x16>
			break;
	}
	while (1) {
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 5dc:	|  ,--|----> move.l dff004 <amiga.c.1d0c19c9+0xdf9323>,d0
 5e2:	|  |  |      move.l d0,8(sp)
		vpos&=0x1ff00;
 5e6:	|  |  |      move.l 8(sp),d0
 5ea:	|  |  |      andi.l #130816,d0
 5f0:	|  |  |      move.l d0,8(sp)
		if (vpos==(311<<8))
 5f4:	|  |  |      move.l 8(sp),d0
 5f8:	|  |  |      cmpi.l #79616,d0
 5fe:	|  +--|----- bne.s 5dc <WaitVbl+0x3a>
 600:	|  |  |      cmpi.w #20153,d1
 604:	|  |  |  ,-- beq.s 612 <WaitVbl+0x70>
 606:	|  |  |  |   cmpi.w #-24562,d1
 60a:	|  |  |  +-- beq.s 612 <WaitVbl+0x70>
			break;
	}
	debug_stop_idle();
}
 60c:	|  |  |  |   movea.l (sp)+,a5
 60e:	|  |  |  |   addq.l #8,sp
 610:	|  |  |  |   rts
		UaeLib(88, arg1, arg2, arg3, arg4);
 612:	|  |  |  '-> clr.l -(sp)
 614:	|  |  |      clr.l -(sp)
 616:	|  |  |      clr.l -(sp)
 618:	|  |  |      pea 5 <_start+0x5>
 61c:	|  |  |      pea 58 <_start+0x58>
 620:	|  |  |      jsr f0ff60 <amiga.c.1d0c19c9+0xf0a27f>
	}
}
 626:	|  |  |      lea 20(sp),sp
 62a:	|  |  |      movea.l (sp)+,a5
 62c:	|  |  |      addq.l #8,sp
 62e:	|  |  |      rts
		UaeLib(88, arg1, arg2, arg3, arg4);
 630:	|  |  '----> clr.l -(sp)
 632:	|  |         clr.l -(sp)
 634:	|  |         pea 1 <_start+0x1>
 638:	|  |         pea 5 <_start+0x5>
 63c:	|  |         pea 58 <_start+0x58>
 640:	|  |         movea.l #15794016,a5
 646:	|  |         jsr (a5)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 648:	|  |         move.w (a5),d1
}
 64a:	|  |         lea 20(sp),sp
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 64e:	|  |         move.l dff004 <amiga.c.1d0c19c9+0xdf9323>,d0
 654:	|  |         move.l d0,4(sp)
		vpos&=0x1ff00;
 658:	|  |         move.l 4(sp),d0
 65c:	|  |         andi.l #130816,d0
 662:	|  |         move.l d0,4(sp)
		if (vpos!=(311<<8))
 666:	|  |         move.l 4(sp),d0
 66a:	|  |         cmpi.l #79616,d0
 670:	'--|-------- beq.w 5b8 <WaitVbl+0x16>
 674:	   '-------- bra.w 5dc <WaitVbl+0x3a>

00000678 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
 678:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
 67a:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
 67e:	jsr -516(a6)
    move.l (sp)+, a6
 682:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
 684:	rts

00000686 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
 686:	move.b d0,(a3)+
	rts
 688:	rts
