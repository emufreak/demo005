
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
   4:	       move.l #66476,d0
   a:	       cmpi.l #66476,d0
  10:	,----- beq.s 2e <_start+0x2e>
	count = __preinit_array_end - __preinit_array_start;
  12:	|      move.l d0,d3
  14:	|      subi.l #66476,d3
  1a:	|      asr.l #2,d3
  1c:	|      lea 103ac <ActiView>,a2
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
  2e:	'----> move.l #66476,d0
  34:	       cmpi.l #66476,d0
  3a:	,----- beq.s 58 <_start+0x58>
	count = __init_array_end - __init_array_start;
  3c:	|      move.l d0,d3
  3e:	|      subi.l #66476,d3
  44:	|      asr.l #2,d3
  46:	|      lea 103ac <ActiView>,a2
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
  58:	'----> jsr 84 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
  5e:	       move.l #66476,d2
  64:	       subi.l #66476,d2
  6a:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  6c:	,----- beq.s 7e <_start+0x7e>
  6e:	|      lea 103ac <ActiView>,a2
		__fini_array_start[i - 1]();
  74:	|  ,-> subq.l #1,d2
  76:	|  |   movea.l -(a2),a0
  78:	|  |   jsr (a0)
	for (i = count; i > 0; i--)
  7a:	|  |   tst.l d2
  7c:	|  '-- bne.s 74 <_start+0x74>
}
  7e:	'----> movem.l (sp)+,d2-d3/a2
  82:	       rts

00000084 <main>:
static void Wait10() { WaitLine(0x10); }
static void Wait11() { WaitLine(0x11); }
static void Wait12() { WaitLine(0x12); }
static void Wait13() { WaitLine(0x13); }

int main() {
  84:	                                              subq.l #4,sp
  86:	                                              movem.l d2-d7/a2-a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
  8a:	                                              movea.l 4 <_start+0x4>,a6
  8e:	                                              move.l a6,103c6 <SysBase>
	custom = (struct Custom*)0xdff000;
  94:	                                              move.l #14675968,103cc <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR)"graphics.library",0);
  9e:	                                              lea bd1 <PutChar+0xcd>,a1
  a4:	                                              moveq #0,d0
  a6:	                                              jsr -552(a6)
  aa:	                                              move.l d0,103c2 <GfxBase>
	if (!GfxBase)
  b0:	      ,-------------------------------------- beq.w 74a <main+0x6c6>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  b4:	      |                                       movea.l 103c6 <SysBase>,a6
  ba:	      |                                       lea be2 <PutChar+0xde>,a1
  c0:	      |                                       moveq #0,d0
  c2:	      |                                       jsr -552(a6)
  c6:	      |                                       move.l d0,103be <DOSBase>
	if (!DOSBase)
  cc:	,-----|-------------------------------------- beq.w 656 <main+0x5d2>
		Exit(0);

	KPrintF("Hello debugger from Amiga!\n");
  d0:	|  ,--|-------------------------------------> pea bee <PutChar+0xea>
  d6:	|  |  |                                       jsr 86e <KPrintF>

	Write(Output(), (APTR)"Hello console!\n", 15);
  dc:	|  |  |                                       movea.l 103be <DOSBase>,a6
  e2:	|  |  |                                       jsr -60(a6)
  e6:	|  |  |                                       movea.l 103be <DOSBase>,a6
  ec:	|  |  |                                       move.l d0,d1
  ee:	|  |  |                                       move.l #3082,d2
  f4:	|  |  |                                       moveq #15,d3
  f6:	|  |  |                                       jsr -48(a6)
	Delay(50);
  fa:	|  |  |                                       movea.l 103be <DOSBase>,a6
 100:	|  |  |                                       moveq #50,d1
 102:	|  |  |                                       jsr -198(a6)

	warpmode(1);
 106:	|  |  |                                       pea 1 <_start+0x1>
 10a:	|  |  |                                       lea 8e0 <warpmode>,a2
 110:	|  |  |                                       jsr (a2)
	// TODO: precalc stuff here

    warpmode(0);
 112:	|  |  |                                       clr.l -(sp)
 114:	|  |  |                                       jsr (a2)
	Forbid();
 116:	|  |  |                                       movea.l 103c6 <SysBase>,a6
 11c:	|  |  |                                       jsr -132(a6)
	SystemADKCON=custom->adkconr;
 120:	|  |  |                                       movea.l 103cc <custom>,a0
 126:	|  |  |                                       move.w 16(a0),d0
 12a:	|  |  |                                       move.w d0,103b0 <SystemADKCON>
	SystemInts=custom->intenar;
 130:	|  |  |                                       move.w 28(a0),d0
 134:	|  |  |                                       move.w d0,103b4 <SystemInts>
	SystemDMA=custom->dmaconr;
 13a:	|  |  |                                       move.w 2(a0),d0
 13e:	|  |  |                                       move.w d0,103b2 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
 144:	|  |  |                                       movea.l 103c2 <GfxBase>,a6
 14a:	|  |  |                                       move.l 34(a6),103ac <ActiView>
	LoadView(0);
 152:	|  |  |                                       suba.l a1,a1
 154:	|  |  |                                       jsr -222(a6)
	WaitTOF();
 158:	|  |  |                                       movea.l 103c2 <GfxBase>,a6
 15e:	|  |  |                                       jsr -270(a6)
	WaitTOF();
 162:	|  |  |                                       movea.l 103c2 <GfxBase>,a6
 168:	|  |  |                                       jsr -270(a6)
	WaitVbl();
 16c:	|  |  |                                       lea 782 <WaitVbl>,a0
 172:	|  |  |                                       jsr (a0)
	WaitVbl();
 174:	|  |  |                                       lea 782 <WaitVbl>,a6
 17a:	|  |  |                                       jsr (a6)
	OwnBlitter();
 17c:	|  |  |                                       movea.l 103c2 <GfxBase>,a6
 182:	|  |  |                                       jsr -456(a6)
	WaitBlit();
 186:	|  |  |                                       movea.l 103c2 <GfxBase>,a6
 18c:	|  |  |                                       jsr -228(a6)
	Disable();
 190:	|  |  |                                       movea.l 103c6 <SysBase>,a6
 196:	|  |  |                                       jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
 19a:	|  |  |                                       movea.l 103cc <custom>,a0
 1a0:	|  |  |                                       move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 1a6:	|  |  |                                       move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 1ac:	|  |  |                                       move.w #32767,150(a0)
 1b2:	|  |  |                                       lea 12(sp),sp
	for(int a=0;a<32;a++)
 1b6:	|  |  |                                       moveq #0,d1
		custom->color[a]=0;
 1b8:	|  |  |  ,----------------------------------> move.l d1,d0
 1ba:	|  |  |  |                                    addi.l #192,d0
 1c0:	|  |  |  |                                    add.l d0,d0
 1c2:	|  |  |  |                                    move.w #0,(0,a0,d0.l)
	for(int a=0;a<32;a++)
 1c8:	|  |  |  |                                    addq.l #1,d1
 1ca:	|  |  |  |                                    moveq #32,d0
 1cc:	|  |  |  |                                    cmp.l d1,d0
 1ce:	|  |  |  +----------------------------------- bne.s 1b8 <main+0x134>
	WaitVbl();
 1d0:	|  |  |  |                                    lea 782 <WaitVbl>,a0
 1d6:	|  |  |  |                                    jsr (a0)
	WaitVbl();
 1d8:	|  |  |  |                                    lea 782 <WaitVbl>,a6
 1de:	|  |  |  |                                    jsr (a6)
	if (SysBase->AttnFlags & AFF_68010)
 1e0:	|  |  |  |                                    movea.l 103c6 <SysBase>,a6
 1e6:	|  |  |  |                                    btst #0,297(a6)
 1ec:	|  |  |  |  ,-------------------------------- beq.w 776 <main+0x6f2>
		vbr = (APTR)Supervisor((ULONG (*)())SupervisorGetVBR);
 1f0:	|  |  |  |  |                                 move.l #1916,d7
 1f6:	|  |  |  |  |                                 exg d7,a5
 1f8:	|  |  |  |  |                                 jsr -30(a6)
 1fc:	|  |  |  |  |                                 exg d7,a5
	VBR=GetVBR();
 1fe:	|  |  |  |  |  ,----------------------------> move.l d0,103ba <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
 204:	|  |  |  |  |  |                              movea.l 103ba <VBR>,a0
 20a:	|  |  |  |  |  |                              move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
 20e:	|  |  |  |  |  |                              move.l d0,103b6 <SystemIrq>

	TakeSystem();
	WaitVbl();
 214:	|  |  |  |  |  |                              lea 782 <WaitVbl>,a0
 21a:	|  |  |  |  |  |                              jsr (a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
 21c:	|  |  |  |  |  |                              movea.l 103ba <VBR>,a0
 222:	|  |  |  |  |  |                              move.l #2116,108(a0)
	// DEMO
	SetInterruptHandler((APTR)interruptHandler);
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
 22a:	|  |  |  |  |  |                              movea.l 103cc <custom>,a0
 230:	|  |  |  |  |  |                              move.w #-16352,154(a0)

	custom->intreq=(1<<INTB_VERTB);//reset vbl req
 236:	|  |  |  |  |  |                              move.w #32,156(a0)
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}
 23c:	|  |  |  |  |  |                              move.b bfe001 <_end+0xbedc31>,d0

	while(!MouseLeft()) {
 242:	|  |  |  |  |  |                              btst #6,d0
 246:	|  |  |  |  |  |  ,-------------------------- beq.w 3c0 <main+0x33c>
 24a:	|  |  |  |  |  |  |                           lea c79 <sinus32>,a4
 250:	|  |  |  |  |  |  |                           lea ac8 <__umodsi3>,a3
 256:	|  |  |  |  |  |  |                           lea c39 <sinus40>,a2
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 25c:	|  |  |  |  |  |  |  ,----------------------> move.l dff004 <_end+0xdeec34>,d0
 262:	|  |  |  |  |  |  |  |                        move.l d0,44(sp)
		if(((vpos >> 8) & 511) == line)
 266:	|  |  |  |  |  |  |  |                        move.l 44(sp),d0
 26a:	|  |  |  |  |  |  |  |                        andi.l #130816,d0
 270:	|  |  |  |  |  |  |  |                        cmpi.l #4096,d0
 276:	|  |  |  |  |  |  |  +----------------------- bne.s 25c <main+0x1d8>
		Wait10();
		int f = frameCounter & 255;
 278:	|  |  |  |  |  |  |  |                        move.w 103ca <frameCounter>,d6

		// clear
		WaitBlit();
 27e:	|  |  |  |  |  |  |  |                        movea.l 103c2 <GfxBase>,a6
 284:	|  |  |  |  |  |  |  |                        jsr -228(a6)
		custom->bltcon0 = A_TO_D | DEST;
 288:	|  |  |  |  |  |  |  |                        movea.l 103cc <custom>,a0
 28e:	|  |  |  |  |  |  |  |                        move.w #496,64(a0)
		custom->bltcon1 = 0;
 294:	|  |  |  |  |  |  |  |                        move.w #0,66(a0)
		custom->bltadat = 0;
 29a:	|  |  |  |  |  |  |  |                        move.w #0,116(a0)
		custom->bltdpt = (UBYTE*)image + 320 / 8 * 200 * 5;
 2a0:	|  |  |  |  |  |  |  |                        move.l #47084,84(a0)
		custom->bltdmod = 0;
 2a8:	|  |  |  |  |  |  |  |                        move.w #0,102(a0)
		custom->bltafwm = custom->bltalwm = 0xffff;
 2ae:	|  |  |  |  |  |  |  |                        move.w #-1,70(a0)
 2b4:	|  |  |  |  |  |  |  |                        move.w #-1,68(a0)
		custom->bltsize = ((56 * 5) << HSIZEBITS) | (320/16);
 2ba:	|  |  |  |  |  |  |  |                        move.w #17940,88(a0)
 2c0:	|  |  |  |  |  |  |  |                        moveq #0,d4
 2c2:	|  |  |  |  |  |  |  |                        suba.l a5,a5

		// blit
		for(short i = 0; i < 16; i++) {
			const short x = i * 16 + sinus32[(frameCounter + i) % sizeof(sinus32)] * 2;
 2c4:	|  |  |  |  |  |  |  |                    ,-> movea.w 103ca <frameCounter>,a0
 2ca:	|  |  |  |  |  |  |  |                    |   pea 33 <_start+0x33>
 2ce:	|  |  |  |  |  |  |  |                    |   pea (0,a5,a0.w)
 2d2:	|  |  |  |  |  |  |  |                    |   jsr (a3)
 2d4:	|  |  |  |  |  |  |  |                    |   addq.l #8,sp
 2d6:	|  |  |  |  |  |  |  |                    |   moveq #0,d3
 2d8:	|  |  |  |  |  |  |  |                    |   move.b (0,a4,d0.l),d3
 2dc:	|  |  |  |  |  |  |  |                    |   add.l d4,d3
 2de:	|  |  |  |  |  |  |  |                    |   add.w d3,d3
			const short y = sinus40[((frameCounter + i) * 2) & 63] / 2;
 2e0:	|  |  |  |  |  |  |  |                    |   movea.w 103ca <frameCounter>,a0
 2e6:	|  |  |  |  |  |  |  |                    |   lea (0,a5,a0.w),a0
 2ea:	|  |  |  |  |  |  |  |                    |   adda.l a0,a0
 2ec:	|  |  |  |  |  |  |  |                    |   move.l a0,d0
 2ee:	|  |  |  |  |  |  |  |                    |   andi.l #62,d0
 2f4:	|  |  |  |  |  |  |  |                    |   move.b (0,a2,d0.l),d2
 2f8:	|  |  |  |  |  |  |  |                    |   lsr.b #1,d2
			UBYTE* src = (UBYTE*)bob + 32 / 8 * 10 * 16 * (i % 6);
 2fa:	|  |  |  |  |  |  |  |                    |   move.w a5,d0
 2fc:	|  |  |  |  |  |  |  |                    |   moveq #6,d1
 2fe:	|  |  |  |  |  |  |  |                    |   ext.l d0
 300:	|  |  |  |  |  |  |  |                    |   divs.w d1,d0
 302:	|  |  |  |  |  |  |  |                    |   move.l d0,d7
 304:	|  |  |  |  |  |  |  |                    |   swap d7
 306:	|  |  |  |  |  |  |  |                    |   muls.w #640,d7
 30a:	|  |  |  |  |  |  |  |                    |   addi.l #3244,d7

			WaitBlit();
 310:	|  |  |  |  |  |  |  |                    |   movea.l 103c2 <GfxBase>,a6
 316:	|  |  |  |  |  |  |  |                    |   jsr -228(a6)
			custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | ((x & 15) << ASHIFTSHIFT); // A = source, B = mask, C = background, D = destination
 31a:	|  |  |  |  |  |  |  |                    |   movea.l 103cc <custom>,a0
 320:	|  |  |  |  |  |  |  |                    |   move.w d3,d0
 322:	|  |  |  |  |  |  |  |                    |   moveq #12,d1
 324:	|  |  |  |  |  |  |  |                    |   lsl.w d1,d0
 326:	|  |  |  |  |  |  |  |                    |   move.w d0,d1
 328:	|  |  |  |  |  |  |  |                    |   ori.w #4042,d1
 32c:	|  |  |  |  |  |  |  |                    |   move.w d1,64(a0)
			custom->bltcon1 = ((x & 15) << BSHIFTSHIFT);
 330:	|  |  |  |  |  |  |  |                    |   move.w d0,66(a0)
			custom->bltapt = src;
 334:	|  |  |  |  |  |  |  |                    |   move.l d7,80(a0)
			custom->bltamod = 32 / 8;
 338:	|  |  |  |  |  |  |  |                    |   move.w #4,100(a0)
			custom->bltbpt = src + 32 / 8 * 1;
 33e:	|  |  |  |  |  |  |  |                    |   addq.l #4,d7
 340:	|  |  |  |  |  |  |  |                    |   move.l d7,76(a0)
			custom->bltbmod = 32 / 8;
 344:	|  |  |  |  |  |  |  |                    |   move.w #4,98(a0)
			custom->bltcpt = custom->bltdpt = (UBYTE*)image + 320 / 8 * 5 * (200 + y) + x / 8;
 34a:	|  |  |  |  |  |  |  |                    |   andi.l #255,d2
 350:	|  |  |  |  |  |  |  |                    |   addi.l #200,d2
 356:	|  |  |  |  |  |  |  |                    |   muls.w #200,d2
 35a:	|  |  |  |  |  |  |  |                    |   asr.w #3,d3
 35c:	|  |  |  |  |  |  |  |                    |   movea.l d2,a6
 35e:	|  |  |  |  |  |  |  |                    |   lea (0,a6,d3.w),a1
 362:	|  |  |  |  |  |  |  |                    |   move.l a1,d0
 364:	|  |  |  |  |  |  |  |                    |   addi.l #7084,d0
 36a:	|  |  |  |  |  |  |  |                    |   move.l d0,84(a0)
 36e:	|  |  |  |  |  |  |  |                    |   move.l d0,72(a0)
			custom->bltcmod = custom->bltdmod = (320 - 32) / 8;
 372:	|  |  |  |  |  |  |  |                    |   move.w #36,102(a0)
 378:	|  |  |  |  |  |  |  |                    |   move.w #36,96(a0)
			custom->bltafwm = custom->bltalwm = 0xffff;
 37e:	|  |  |  |  |  |  |  |                    |   move.w #-1,70(a0)
 384:	|  |  |  |  |  |  |  |                    |   move.w #-1,68(a0)
			custom->bltsize = ((16 * 5) << HSIZEBITS) | (32/16);
 38a:	|  |  |  |  |  |  |  |                    |   move.w #5122,88(a0)
		for(short i = 0; i < 16; i++) {
 390:	|  |  |  |  |  |  |  |                    |   addq.l #1,a5
 392:	|  |  |  |  |  |  |  |                    |   addq.l #8,d4
 394:	|  |  |  |  |  |  |  |                    |   moveq #16,d1
 396:	|  |  |  |  |  |  |  |                    |   cmp.l a5,d1
 398:	|  |  |  |  |  |  |  |                    '-- bne.w 2c4 <main+0x240>
}

static void debug_cmd(unsigned int arg1, unsigned int arg2, unsigned int arg3, unsigned int arg4) {
	long(*UaeLib)(unsigned int arg0, unsigned int arg1, unsigned int arg2, unsigned int arg3, unsigned int arg4);
	UaeLib = (long(*)(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int))0xf0ff60;
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 39c:	|  |  |  |  |  |  |  |                        move.w f0ff60 <_end+0xeffb90>,d0
 3a2:	|  |  |  |  |  |  |  |                        cmpi.w #20153,d0
 3a6:	|  |  |  |  |  |  |  |                    ,-- beq.w 4aa <main+0x426>
 3aa:	|  |  |  |  |  |  |  |                    |   cmpi.w #-24562,d0
 3ae:	|  |  |  |  |  |  |  |                    +-- beq.w 4aa <main+0x426>
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}
 3b2:	|  |  |  |  |  |  |  |  ,-----------------|-> move.b bfe001 <_end+0xbedc31>,d0
	while(!MouseLeft()) {
 3b8:	|  |  |  |  |  |  |  |  |                 |   btst #6,d0
 3bc:	|  |  |  |  |  |  |  +--|-----------------|-- bne.w 25c <main+0x1d8>
	WaitVbl();
 3c0:	|  |  |  |  |  |  >--|--|-----------------|-> lea 782 <WaitVbl>,a0
 3c6:	|  |  |  |  |  |  |  |  |                 |   jsr (a0)
	WaitBlit();
 3c8:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c2 <GfxBase>,a6
 3ce:	|  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	custom->intena=0x7fff;//disable all interrupts
 3d2:	|  |  |  |  |  |  |  |  |                 |   movea.l 103cc <custom>,a0
 3d8:	|  |  |  |  |  |  |  |  |                 |   move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 3de:	|  |  |  |  |  |  |  |  |                 |   move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 3e4:	|  |  |  |  |  |  |  |  |                 |   move.w #32767,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
 3ea:	|  |  |  |  |  |  |  |  |                 |   movea.l 103ba <VBR>,a1
 3f0:	|  |  |  |  |  |  |  |  |                 |   move.l 103b6 <SystemIrq>,108(a1)
	custom->cop1lc=(ULONG)GfxBase->copinit;
 3f8:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c2 <GfxBase>,a6
 3fe:	|  |  |  |  |  |  |  |  |                 |   move.l 38(a6),128(a0)
	custom->cop2lc=(ULONG)GfxBase->LOFlist;
 404:	|  |  |  |  |  |  |  |  |                 |   move.l 50(a6),132(a0)
	custom->copjmp1=0x7fff; //start coppper
 40a:	|  |  |  |  |  |  |  |  |                 |   move.w #32767,136(a0)
	custom->intena=SystemInts|0x8000;
 410:	|  |  |  |  |  |  |  |  |                 |   move.w 103b4 <SystemInts>,d0
 416:	|  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
 41a:	|  |  |  |  |  |  |  |  |                 |   move.w d0,154(a0)
	custom->dmacon=SystemDMA|0x8000;
 41e:	|  |  |  |  |  |  |  |  |                 |   move.w 103b2 <SystemDMA>,d0
 424:	|  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
 428:	|  |  |  |  |  |  |  |  |                 |   move.w d0,150(a0)
	custom->adkcon=SystemADKCON|0x8000;
 42c:	|  |  |  |  |  |  |  |  |                 |   move.w 103b0 <SystemADKCON>,d0
 432:	|  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
 436:	|  |  |  |  |  |  |  |  |                 |   move.w d0,158(a0)
	WaitBlit();
 43a:	|  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	DisownBlitter();
 43e:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c2 <GfxBase>,a6
 444:	|  |  |  |  |  |  |  |  |                 |   jsr -462(a6)
	Enable();
 448:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c6 <SysBase>,a6
 44e:	|  |  |  |  |  |  |  |  |                 |   jsr -126(a6)
	LoadView(ActiView);
 452:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c2 <GfxBase>,a6
 458:	|  |  |  |  |  |  |  |  |                 |   movea.l 103ac <ActiView>,a1
 45e:	|  |  |  |  |  |  |  |  |                 |   jsr -222(a6)
	WaitTOF();
 462:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c2 <GfxBase>,a6
 468:	|  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	WaitTOF();
 46c:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c2 <GfxBase>,a6
 472:	|  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	Permit();
 476:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c6 <SysBase>,a6
 47c:	|  |  |  |  |  |  |  |  |                 |   jsr -138(a6)
	}

	// END
	FreeSystem();

	CloseLibrary((struct Library*)DOSBase);
 480:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c6 <SysBase>,a6
 486:	|  |  |  |  |  |  |  |  |                 |   movea.l 103be <DOSBase>,a1
 48c:	|  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
	CloseLibrary((struct Library*)GfxBase);
 490:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c6 <SysBase>,a6
 496:	|  |  |  |  |  |  |  |  |                 |   movea.l 103c2 <GfxBase>,a1
 49c:	|  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
}
 4a0:	|  |  |  |  |  |  |  |  |                 |   moveq #0,d0
 4a2:	|  |  |  |  |  |  |  |  |                 |   movem.l (sp)+,d2-d7/a2-a6
 4a6:	|  |  |  |  |  |  |  |  |                 |   addq.l #4,sp
 4a8:	|  |  |  |  |  |  |  |  |                 |   rts
		UaeLib(88, arg1, arg2, arg3, arg4);
 4aa:	|  |  |  |  |  |  |  |  |                 '-> clr.l -(sp)
 4ac:	|  |  |  |  |  |  |  |  |                     clr.l -(sp)
 4ae:	|  |  |  |  |  |  |  |  |                     clr.l -(sp)
 4b0:	|  |  |  |  |  |  |  |  |                     clr.l -(sp)
 4b2:	|  |  |  |  |  |  |  |  |                     pea 58 <_start+0x58>
 4b6:	|  |  |  |  |  |  |  |  |                     movea.l #15794016,a5
 4bc:	|  |  |  |  |  |  |  |  |                     jsr (a5)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 4be:	|  |  |  |  |  |  |  |  |                     move.w (a5),d0
 4c0:	|  |  |  |  |  |  |  |  |                     lea 20(sp),sp
 4c4:	|  |  |  |  |  |  |  |  |                     cmpi.w #20153,d0
 4c8:	|  |  |  |  |  |  |  |  |                 ,-- bne.w 58c <main+0x508>
		debug_filled_rect(f + 100, 200*2, f + 400, 220*2, 0x0000ff00); // 0x00RRGGBB
 4cc:	|  |  |  |  |  |  |  |  |                 |   andi.w #255,d6
 4d0:	|  |  |  |  |  |  |  |  |                 |   move.w d6,d2
 4d2:	|  |  |  |  |  |  |  |  |                 |   addi.w #400,d2
void debug_rect(short left, short top, short right, short bottom, unsigned int color) {
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
}

void debug_filled_rect(short left, short top, short right, short bottom, unsigned int color) {
	debug_cmd(barto_cmd_filled_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
 4d6:	|  |  |  |  |  |  |  |  |                 |   swap d2
 4d8:	|  |  |  |  |  |  |  |  |                 |   clr.w d2
		UaeLib(88, arg1, arg2, arg3, arg4);
 4da:	|  |  |  |  |  |  |  |  |                 |   move.l #65280,-(sp)
 4e0:	|  |  |  |  |  |  |  |  |                 |   move.l d2,d0
 4e2:	|  |  |  |  |  |  |  |  |                 |   ori.w #440,d0
 4e6:	|  |  |  |  |  |  |  |  |                 |   move.l d0,-(sp)
 4e8:	|  |  |  |  |  |  |  |  |                 |   move.w d6,d0
 4ea:	|  |  |  |  |  |  |  |  |                 |   addi.w #100,d0
	debug_cmd(barto_cmd_filled_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
 4ee:	|  |  |  |  |  |  |  |  |                 |   swap d0
 4f0:	|  |  |  |  |  |  |  |  |                 |   clr.w d0
		UaeLib(88, arg1, arg2, arg3, arg4);
 4f2:	|  |  |  |  |  |  |  |  |                 |   ori.w #400,d0
 4f6:	|  |  |  |  |  |  |  |  |                 |   move.l d0,-(sp)
 4f8:	|  |  |  |  |  |  |  |  |                 |   pea 2 <_start+0x2>
 4fc:	|  |  |  |  |  |  |  |  |                 |   pea 58 <_start+0x58>
 500:	|  |  |  |  |  |  |  |  |                 |   movea.l #15794016,a5
 506:	|  |  |  |  |  |  |  |  |                 |   jsr (a5)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 508:	|  |  |  |  |  |  |  |  |                 |   move.w (a5),d0
 50a:	|  |  |  |  |  |  |  |  |                 |   lea 20(sp),sp
 50e:	|  |  |  |  |  |  |  |  |                 |   cmpi.w #20153,d0
 512:	|  |  |  |  |  |  |  |  |           ,-----|-- bne.w 5de <main+0x55a>
		UaeLib(88, arg1, arg2, arg3, arg4);
 516:	|  |  |  |  |  |  |  |  |           |  ,--|-> pea ff <main+0x7b>
 51a:	|  |  |  |  |  |  |  |  |           |  |  |   ori.w #440,d2
 51e:	|  |  |  |  |  |  |  |  |           |  |  |   move.l d2,-(sp)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
 520:	|  |  |  |  |  |  |  |  |           |  |  |   move.w d6,d0
 522:	|  |  |  |  |  |  |  |  |           |  |  |   addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
 526:	|  |  |  |  |  |  |  |  |           |  |  |   swap d0
 528:	|  |  |  |  |  |  |  |  |           |  |  |   clr.w d0
		UaeLib(88, arg1, arg2, arg3, arg4);
 52a:	|  |  |  |  |  |  |  |  |           |  |  |   ori.w #380,d0
 52e:	|  |  |  |  |  |  |  |  |           |  |  |   move.l d0,-(sp)
 530:	|  |  |  |  |  |  |  |  |           |  |  |   pea 1 <_start+0x1>
 534:	|  |  |  |  |  |  |  |  |           |  |  |   pea 58 <_start+0x58>
 538:	|  |  |  |  |  |  |  |  |           |  |  |   movea.l #15794016,a5
 53e:	|  |  |  |  |  |  |  |  |           |  |  |   jsr (a5)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 540:	|  |  |  |  |  |  |  |  |           |  |  |   move.w (a5),d0
 542:	|  |  |  |  |  |  |  |  |           |  |  |   lea 20(sp),sp
 546:	|  |  |  |  |  |  |  |  |           |  |  |   cmpi.w #20153,d0
 54a:	|  |  |  |  |  |  |  |  |     ,-----|--|--|-- bne.w 61e <main+0x59a>
		UaeLib(88, arg1, arg2, arg3, arg4);
 54e:	|  |  |  |  |  |  |  |  |     |  ,--|--|--|-> move.l #16711935,-(sp)
 554:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   pea c1a <PutChar+0x116>
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
 55a:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   addi.w #130,d6
}

void debug_text(short left, short top, const char* text, unsigned int color) {
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
 55e:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   swap d6
 560:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   clr.w d6
		UaeLib(88, arg1, arg2, arg3, arg4);
 562:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   ori.w #418,d6
 566:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   move.l d6,-(sp)
 568:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   pea 3 <_start+0x3>
 56c:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   pea 58 <_start+0x58>
 570:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   jsr f0ff60 <_end+0xeffb90>
}
 576:	|  |  |  |  |  |  |  |  |     |  |  |  |  |   lea 20(sp),sp
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}
 57a:	|  |  |  |  |  |  |  |  |  ,--|--|--|--|--|-> move.b bfe001 <_end+0xbedc31>,d0
	while(!MouseLeft()) {
 580:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |   btst #6,d0
 584:	|  |  |  |  |  |  |  '--|--|--|--|--|--|--|-- bne.w 25c <main+0x1d8>
 588:	|  |  |  |  |  |  '-----|--|--|--|--|--|--|-- bra.w 3c0 <main+0x33c>
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 58c:	|  |  |  |  |  |        |  |  |  |  |  |  '-> cmpi.w #-24562,d0
 590:	|  |  |  |  |  |        +--|--|--|--|--|----- bne.w 3b2 <main+0x32e>
		debug_filled_rect(f + 100, 200*2, f + 400, 220*2, 0x0000ff00); // 0x00RRGGBB
 594:	|  |  |  |  |  |        |  |  |  |  |  |      andi.w #255,d6
 598:	|  |  |  |  |  |        |  |  |  |  |  |      move.w d6,d2
 59a:	|  |  |  |  |  |        |  |  |  |  |  |      addi.w #400,d2
	debug_cmd(barto_cmd_filled_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
 59e:	|  |  |  |  |  |        |  |  |  |  |  |      swap d2
 5a0:	|  |  |  |  |  |        |  |  |  |  |  |      clr.w d2
		UaeLib(88, arg1, arg2, arg3, arg4);
 5a2:	|  |  |  |  |  |        |  |  |  |  |  |      move.l #65280,-(sp)
 5a8:	|  |  |  |  |  |        |  |  |  |  |  |      move.l d2,d0
 5aa:	|  |  |  |  |  |        |  |  |  |  |  |      ori.w #440,d0
 5ae:	|  |  |  |  |  |        |  |  |  |  |  |      move.l d0,-(sp)
 5b0:	|  |  |  |  |  |        |  |  |  |  |  |      move.w d6,d0
 5b2:	|  |  |  |  |  |        |  |  |  |  |  |      addi.w #100,d0
	debug_cmd(barto_cmd_filled_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
 5b6:	|  |  |  |  |  |        |  |  |  |  |  |      swap d0
 5b8:	|  |  |  |  |  |        |  |  |  |  |  |      clr.w d0
		UaeLib(88, arg1, arg2, arg3, arg4);
 5ba:	|  |  |  |  |  |        |  |  |  |  |  |      ori.w #400,d0
 5be:	|  |  |  |  |  |        |  |  |  |  |  |      move.l d0,-(sp)
 5c0:	|  |  |  |  |  |        |  |  |  |  |  |      pea 2 <_start+0x2>
 5c4:	|  |  |  |  |  |        |  |  |  |  |  |      pea 58 <_start+0x58>
 5c8:	|  |  |  |  |  |        |  |  |  |  |  |      movea.l #15794016,a5
 5ce:	|  |  |  |  |  |        |  |  |  |  |  |      jsr (a5)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 5d0:	|  |  |  |  |  |        |  |  |  |  |  |      move.w (a5),d0
 5d2:	|  |  |  |  |  |        |  |  |  |  |  |      lea 20(sp),sp
 5d6:	|  |  |  |  |  |        |  |  |  |  |  |      cmpi.w #20153,d0
 5da:	|  |  |  |  |  |        |  |  |  |  |  '----- beq.w 516 <main+0x492>
 5de:	|  |  |  |  |  |        |  |  |  |  '-------> cmpi.w #-24562,d0
 5e2:	|  |  |  |  |  |        +--|--|--|----------- bne.w 3b2 <main+0x32e>
		UaeLib(88, arg1, arg2, arg3, arg4);
 5e6:	|  |  |  |  |  |        |  |  |  |            pea ff <main+0x7b>
 5ea:	|  |  |  |  |  |        |  |  |  |            ori.w #440,d2
 5ee:	|  |  |  |  |  |        |  |  |  |            move.l d2,-(sp)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
 5f0:	|  |  |  |  |  |        |  |  |  |            move.w d6,d0
 5f2:	|  |  |  |  |  |        |  |  |  |            addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
 5f6:	|  |  |  |  |  |        |  |  |  |            swap d0
 5f8:	|  |  |  |  |  |        |  |  |  |            clr.w d0
		UaeLib(88, arg1, arg2, arg3, arg4);
 5fa:	|  |  |  |  |  |        |  |  |  |            ori.w #380,d0
 5fe:	|  |  |  |  |  |        |  |  |  |            move.l d0,-(sp)
 600:	|  |  |  |  |  |        |  |  |  |            pea 1 <_start+0x1>
 604:	|  |  |  |  |  |        |  |  |  |            pea 58 <_start+0x58>
 608:	|  |  |  |  |  |        |  |  |  |            movea.l #15794016,a5
 60e:	|  |  |  |  |  |        |  |  |  |            jsr (a5)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 610:	|  |  |  |  |  |        |  |  |  |            move.w (a5),d0
 612:	|  |  |  |  |  |        |  |  |  |            lea 20(sp),sp
 616:	|  |  |  |  |  |        |  |  |  |            cmpi.w #20153,d0
 61a:	|  |  |  |  |  |        |  |  |  '----------- beq.w 54e <main+0x4ca>
 61e:	|  |  |  |  |  |        |  |  '-------------> cmpi.w #-24562,d0
 622:	|  |  |  |  |  |        '--|----------------- bne.w 3b2 <main+0x32e>
		UaeLib(88, arg1, arg2, arg3, arg4);
 626:	|  |  |  |  |  |           |                  move.l #16711935,-(sp)
 62c:	|  |  |  |  |  |           |                  pea c1a <PutChar+0x116>
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
 632:	|  |  |  |  |  |           |                  addi.w #130,d6
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
 636:	|  |  |  |  |  |           |                  swap d6
 638:	|  |  |  |  |  |           |                  clr.w d6
		UaeLib(88, arg1, arg2, arg3, arg4);
 63a:	|  |  |  |  |  |           |                  ori.w #418,d6
 63e:	|  |  |  |  |  |           |                  move.l d6,-(sp)
 640:	|  |  |  |  |  |           |                  pea 3 <_start+0x3>
 644:	|  |  |  |  |  |           |                  pea 58 <_start+0x58>
 648:	|  |  |  |  |  |           |                  jsr f0ff60 <_end+0xeffb90>
}
 64e:	|  |  |  |  |  |           |                  lea 20(sp),sp
 652:	|  |  |  |  |  |           '----------------- bra.w 57a <main+0x4f6>
		Exit(0);
 656:	>--|--|--|--|--|----------------------------> suba.l a6,a6
 658:	|  |  |  |  |  |                              moveq #0,d1
 65a:	|  |  |  |  |  |                              jsr -144(a6)
	KPrintF("Hello debugger from Amiga!\n");
 65e:	|  |  |  |  |  |                              pea bee <PutChar+0xea>
 664:	|  |  |  |  |  |                              jsr 86e <KPrintF>
	Write(Output(), (APTR)"Hello console!\n", 15);
 66a:	|  |  |  |  |  |                              movea.l 103be <DOSBase>,a6
 670:	|  |  |  |  |  |                              jsr -60(a6)
 674:	|  |  |  |  |  |                              movea.l 103be <DOSBase>,a6
 67a:	|  |  |  |  |  |                              move.l d0,d1
 67c:	|  |  |  |  |  |                              move.l #3082,d2
 682:	|  |  |  |  |  |                              moveq #15,d3
 684:	|  |  |  |  |  |                              jsr -48(a6)
	Delay(50);
 688:	|  |  |  |  |  |                              movea.l 103be <DOSBase>,a6
 68e:	|  |  |  |  |  |                              moveq #50,d1
 690:	|  |  |  |  |  |                              jsr -198(a6)
	warpmode(1);
 694:	|  |  |  |  |  |                              pea 1 <_start+0x1>
 698:	|  |  |  |  |  |                              lea 8e0 <warpmode>,a2
 69e:	|  |  |  |  |  |                              jsr (a2)
    warpmode(0);
 6a0:	|  |  |  |  |  |                              clr.l -(sp)
 6a2:	|  |  |  |  |  |                              jsr (a2)
	Forbid();
 6a4:	|  |  |  |  |  |                              movea.l 103c6 <SysBase>,a6
 6aa:	|  |  |  |  |  |                              jsr -132(a6)
	SystemADKCON=custom->adkconr;
 6ae:	|  |  |  |  |  |                              movea.l 103cc <custom>,a0
 6b4:	|  |  |  |  |  |                              move.w 16(a0),d0
 6b8:	|  |  |  |  |  |                              move.w d0,103b0 <SystemADKCON>
	SystemInts=custom->intenar;
 6be:	|  |  |  |  |  |                              move.w 28(a0),d0
 6c2:	|  |  |  |  |  |                              move.w d0,103b4 <SystemInts>
	SystemDMA=custom->dmaconr;
 6c8:	|  |  |  |  |  |                              move.w 2(a0),d0
 6cc:	|  |  |  |  |  |                              move.w d0,103b2 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
 6d2:	|  |  |  |  |  |                              movea.l 103c2 <GfxBase>,a6
 6d8:	|  |  |  |  |  |                              move.l 34(a6),103ac <ActiView>
	LoadView(0);
 6e0:	|  |  |  |  |  |                              suba.l a1,a1
 6e2:	|  |  |  |  |  |                              jsr -222(a6)
	WaitTOF();
 6e6:	|  |  |  |  |  |                              movea.l 103c2 <GfxBase>,a6
 6ec:	|  |  |  |  |  |                              jsr -270(a6)
	WaitTOF();
 6f0:	|  |  |  |  |  |                              movea.l 103c2 <GfxBase>,a6
 6f6:	|  |  |  |  |  |                              jsr -270(a6)
	WaitVbl();
 6fa:	|  |  |  |  |  |                              lea 782 <WaitVbl>,a0
 700:	|  |  |  |  |  |                              jsr (a0)
	WaitVbl();
 702:	|  |  |  |  |  |                              lea 782 <WaitVbl>,a6
 708:	|  |  |  |  |  |                              jsr (a6)
	OwnBlitter();
 70a:	|  |  |  |  |  |                              movea.l 103c2 <GfxBase>,a6
 710:	|  |  |  |  |  |                              jsr -456(a6)
	WaitBlit();
 714:	|  |  |  |  |  |                              movea.l 103c2 <GfxBase>,a6
 71a:	|  |  |  |  |  |                              jsr -228(a6)
	Disable();
 71e:	|  |  |  |  |  |                              movea.l 103c6 <SysBase>,a6
 724:	|  |  |  |  |  |                              jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
 728:	|  |  |  |  |  |                              movea.l 103cc <custom>,a0
 72e:	|  |  |  |  |  |                              move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 734:	|  |  |  |  |  |                              move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 73a:	|  |  |  |  |  |                              move.w #32767,150(a0)
 740:	|  |  |  |  |  |                              lea 12(sp),sp
	for(int a=0;a<32;a++)
 744:	|  |  |  |  |  |                              moveq #0,d1
 746:	|  |  |  '--|--|----------------------------- bra.w 1b8 <main+0x134>
		Exit(0);
 74a:	|  |  '-----|--|----------------------------> movea.l 103be <DOSBase>,a6
 750:	|  |        |  |                              moveq #0,d1
 752:	|  |        |  |                              jsr -144(a6)
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
 756:	|  |        |  |                              movea.l 103c6 <SysBase>,a6
 75c:	|  |        |  |                              lea be2 <PutChar+0xde>,a1
 762:	|  |        |  |                              moveq #0,d0
 764:	|  |        |  |                              jsr -552(a6)
 768:	|  |        |  |                              move.l d0,103be <DOSBase>
	if (!DOSBase)
 76e:	|  '--------|--|----------------------------- bne.w d0 <main+0x4c>
 772:	'-----------|--|----------------------------- bra.w 656 <main+0x5d2>
	APTR vbr = 0;
 776:	            '--|----------------------------> moveq #0,d0
 778:	               '----------------------------- bra.w 1fe <main+0x17a>

0000077c <SupervisorGetVBR>:
	__asm__ volatile(".short 0x4e7a, 0x0801"); // movec.l vbr, d0
 77c:	.short 0x4e7a
 77e:	btst #115,d1

00000782 <WaitVbl>:
void WaitVbl() {
 782:	             subq.l #8,sp
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 784:	             move.w f0ff60 <_end+0xeffb90>,d0
 78a:	             cmpi.w #20153,d0
 78e:	      ,----- beq.s 808 <WaitVbl+0x86>
 790:	      |      cmpi.w #-24562,d0
 794:	      +----- beq.s 808 <WaitVbl+0x86>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 796:	,-----|----> move.l dff004 <_end+0xdeec34>,d0
 79c:	|     |      move.l d0,(sp)
		vpos&=0x1ff00;
 79e:	|     |      move.l (sp),d0
 7a0:	|     |      andi.l #130816,d0
 7a6:	|     |      move.l d0,(sp)
		if (vpos!=(311<<8))
 7a8:	|     |      move.l (sp),d0
 7aa:	|     |      cmpi.l #79616,d0
 7b0:	+-----|----- beq.s 796 <WaitVbl+0x14>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 7b2:	|  ,--|----> move.l dff004 <_end+0xdeec34>,d0
 7b8:	|  |  |      move.l d0,4(sp)
		vpos&=0x1ff00;
 7bc:	|  |  |      move.l 4(sp),d0
 7c0:	|  |  |      andi.l #130816,d0
 7c6:	|  |  |      move.l d0,4(sp)
		if (vpos==(311<<8))
 7ca:	|  |  |      move.l 4(sp),d0
 7ce:	|  |  |      cmpi.l #79616,d0
 7d4:	|  +--|----- bne.s 7b2 <WaitVbl+0x30>
 7d6:	|  |  |      move.w f0ff60 <_end+0xeffb90>,d0
 7dc:	|  |  |      cmpi.w #20153,d0
 7e0:	|  |  |  ,-- beq.s 7ec <WaitVbl+0x6a>
 7e2:	|  |  |  |   cmpi.w #-24562,d0
 7e6:	|  |  |  +-- beq.s 7ec <WaitVbl+0x6a>
}
 7e8:	|  |  |  |   addq.l #8,sp
 7ea:	|  |  |  |   rts
		UaeLib(88, arg1, arg2, arg3, arg4);
 7ec:	|  |  |  '-> clr.l -(sp)
 7ee:	|  |  |      clr.l -(sp)
 7f0:	|  |  |      clr.l -(sp)
 7f2:	|  |  |      pea 5 <_start+0x5>
 7f6:	|  |  |      pea 58 <_start+0x58>
 7fa:	|  |  |      jsr f0ff60 <_end+0xeffb90>
}
 800:	|  |  |      lea 20(sp),sp
 804:	|  |  |      addq.l #8,sp
 806:	|  |  |      rts
		UaeLib(88, arg1, arg2, arg3, arg4);
 808:	|  |  '----> clr.l -(sp)
 80a:	|  |         clr.l -(sp)
 80c:	|  |         pea 1 <_start+0x1>
 810:	|  |         pea 5 <_start+0x5>
 814:	|  |         pea 58 <_start+0x58>
 818:	|  |         jsr f0ff60 <_end+0xeffb90>
}
 81e:	|  |         lea 20(sp),sp
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 822:	|  |         move.l dff004 <_end+0xdeec34>,d0
 828:	|  |         move.l d0,(sp)
		vpos&=0x1ff00;
 82a:	|  |         move.l (sp),d0
 82c:	|  |         andi.l #130816,d0
 832:	|  |         move.l d0,(sp)
		if (vpos!=(311<<8))
 834:	|  |         move.l (sp),d0
 836:	|  |         cmpi.l #79616,d0
 83c:	'--|-------- beq.w 796 <WaitVbl+0x14>
 840:	   '-------- bra.w 7b2 <WaitVbl+0x30>

00000844 <interruptHandler>:
static __attribute__((interrupt)) void interruptHandler() {
 844:	move.l a0,-(sp)
 846:	move.l d0,-(sp)
	custom->intreq=(1<<INTB_VERTB); custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.
 848:	movea.l 103cc <custom>,a0
 84e:	move.w #32,156(a0)
 854:	move.w #32,156(a0)
	frameCounter++;
 85a:	move.w 103ca <frameCounter>,d0
 860:	addq.w #1,d0
 862:	move.w d0,103ca <frameCounter>
}
 868:	move.l (sp)+,d0
 86a:	movea.l (sp)+,a0
 86c:	rte

0000086e <KPrintF>:
void KPrintF(const char* fmt, ...) {
 86e:	    lea -128(sp),sp
 872:	    movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
 876:	    move.w f0ff60 <_end+0xeffb90>,d0
 87c:	    cmpi.w #20153,d0
 880:	,-- beq.s 8ac <KPrintF+0x3e>
 882:	|   cmpi.w #-24562,d0
 886:	+-- beq.s 8ac <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
 888:	|   movea.l 103c6 <SysBase>,a6
 88e:	|   movea.l 144(sp),a0
 892:	|   lea 148(sp),a1
 896:	|   lea af6 <KPutCharX>,a2
 89c:	|   suba.l a3,a3
 89e:	|   jsr -522(a6)
}
 8a2:	|   movem.l (sp)+,a2-a3/a6
 8a6:	|   lea 128(sp),sp
 8aa:	|   rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
 8ac:	'-> movea.l 103c6 <SysBase>,a6
 8b2:	    movea.l 144(sp),a0
 8b6:	    lea 148(sp),a1
 8ba:	    lea b04 <PutChar>,a2
 8c0:	    lea 12(sp),a3
 8c4:	    jsr -522(a6)
		UaeDbgLog(86, temp);
 8c8:	    move.l a3,-(sp)
 8ca:	    pea 56 <_start+0x56>
 8ce:	    jsr f0ff60 <_end+0xeffb90>
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
 8d4:	    addq.l #8,sp
}
 8d6:	    movem.l (sp)+,a2-a3/a6
 8da:	    lea 128(sp),sp
 8de:	    rts

000008e0 <warpmode>:
void warpmode(int on) { // bool
 8e0:	       subq.l #4,sp
 8e2:	       move.l a5,-(sp)
	if(*((UWORD *)UaeConf) == 0x4eb9 || *((UWORD *)UaeConf) == 0xa00e) {
 8e4:	       move.w f0ff60 <_end+0xeffb90>,d0
 8ea:	       cmpi.w #20153,d0
 8ee:	   ,-- beq.s 8fc <warpmode+0x1c>
 8f0:	   |   cmpi.w #-24562,d0
 8f4:	   +-- beq.s 8fc <warpmode+0x1c>
}
 8f6:	   |   movea.l (sp)+,a5
 8f8:	   |   addq.l #4,sp
 8fa:	   |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
 8fc:	   '-> tst.l 12(sp)
 900:	,----- beq.w 9a8 <warpmode+0xc8>
 904:	|      pea 1 <_start+0x1>
 908:	|      lea 11(sp),a5
 90c:	|      move.l a5,-(sp)
 90e:	|      clr.l -(sp)
 910:	|      pea b76 <PutChar+0x72>
 916:	|      pea ffffffff <_end+0xfffefc2f>
 91a:	|      pea 52 <_start+0x52>
 91e:	|      jsr f0ff60 <_end+0xeffb90>
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
 924:	|      pea 1 <_start+0x1>
 928:	|      move.l a5,-(sp)
 92a:	|      clr.l -(sp)
 92c:	|      pea b84 <PutChar+0x80>
 932:	|      pea ffffffff <_end+0xfffefc2f>
 936:	|      pea 52 <_start+0x52>
 93a:	|      jsr f0ff60 <_end+0xeffb90>
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
 940:	|      lea 48(sp),sp
 944:	|      pea 1 <_start+0x1>
 948:	|      move.l a5,-(sp)
 94a:	|      clr.l -(sp)
 94c:	|      pea b9a <PutChar+0x96>
 952:	|      pea ffffffff <_end+0xfffefc2f>
 956:	|      pea 52 <_start+0x52>
 95a:	|      jsr f0ff60 <_end+0xeffb90>
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
 960:	|      pea 1 <_start+0x1>
 964:	|      move.l a5,-(sp)
 966:	|      clr.l -(sp)
 968:	|      pea bb7 <PutChar+0xb3>
 96e:	|      pea ffffffff <_end+0xfffefc2f>
 972:	|      pea 52 <_start+0x52>
 976:	|      jsr f0ff60 <_end+0xeffb90>
 97c:	|      lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
 980:	|      move.l #2824,d0
 986:	|      pea 1 <_start+0x1>
 98a:	|      move.l a5,-(sp)
 98c:	|      clr.l -(sp)
 98e:	|      move.l d0,-(sp)
 990:	|      pea ffffffff <_end+0xfffefc2f>
 994:	|      pea 52 <_start+0x52>
 998:	|      jsr f0ff60 <_end+0xeffb90>
}
 99e:	|      lea 24(sp),sp
 9a2:	|  ,-> movea.l (sp)+,a5
 9a4:	|  |   addq.l #4,sp
 9a6:	|  |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
 9a8:	'--|-> pea 1 <_start+0x1>
 9ac:	   |   lea 11(sp),a5
 9b0:	   |   move.l a5,-(sp)
 9b2:	   |   clr.l -(sp)
 9b4:	   |   pea b1d <PutChar+0x19>
 9ba:	   |   pea ffffffff <_end+0xfffefc2f>
 9be:	   |   pea 52 <_start+0x52>
 9c2:	   |   jsr f0ff60 <_end+0xeffb90>
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
 9c8:	   |   pea 1 <_start+0x1>
 9cc:	   |   move.l a5,-(sp)
 9ce:	   |   clr.l -(sp)
 9d0:	   |   pea b2c <PutChar+0x28>
 9d6:	   |   pea ffffffff <_end+0xfffefc2f>
 9da:	   |   pea 52 <_start+0x52>
 9de:	   |   jsr f0ff60 <_end+0xeffb90>
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
 9e4:	   |   lea 48(sp),sp
 9e8:	   |   pea 1 <_start+0x1>
 9ec:	   |   move.l a5,-(sp)
 9ee:	   |   clr.l -(sp)
 9f0:	   |   pea b41 <PutChar+0x3d>
 9f6:	   |   pea ffffffff <_end+0xfffefc2f>
 9fa:	   |   pea 52 <_start+0x52>
 9fe:	   |   jsr f0ff60 <_end+0xeffb90>
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
 a04:	   |   pea 1 <_start+0x1>
 a08:	   |   move.l a5,-(sp)
 a0a:	   |   clr.l -(sp)
 a0c:	   |   pea b5d <PutChar+0x59>
 a12:	   |   pea ffffffff <_end+0xfffefc2f>
 a16:	   |   pea 52 <_start+0x52>
 a1a:	   |   jsr f0ff60 <_end+0xeffb90>
 a20:	   |   lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
 a24:	   |   move.l #2834,d0
 a2a:	   |   pea 1 <_start+0x1>
 a2e:	   |   move.l a5,-(sp)
 a30:	   |   clr.l -(sp)
 a32:	   |   move.l d0,-(sp)
 a34:	   |   pea ffffffff <_end+0xfffefc2f>
 a38:	   |   pea 52 <_start+0x52>
 a3c:	   |   jsr f0ff60 <_end+0xeffb90>
}
 a42:	   |   lea 24(sp),sp
 a46:	   '-- bra.w 9a2 <warpmode+0xc2>

00000a4a <__mulsi3>:
	.section .text.__mulsi3,"ax",@progbits
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
 a4a:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
 a4e:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
 a52:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
 a56:	mulu.w 8(sp),d1
	addw	d1, d0
 a5a:	add.w d1,d0
	swap	d0
 a5c:	swap d0
	clrw	d0
 a5e:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
 a60:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
 a64:	mulu.w 10(sp),d1
	addl	d1, d0
 a68:	add.l d1,d0
	rts
 a6a:	rts

00000a6c <__udivsi3>:
	.section .text.__udivsi3,"ax",@progbits
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
 a6c:	       move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
 a6e:	       move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
 a72:	       move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
 a76:	       cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
 a7c:	   ,-- bcc.s a94 <__udivsi3+0x28>
	movel	d0, d2
 a7e:	   |   move.l d0,d2
	clrw	d2
 a80:	   |   clr.w d2
	swap	d2
 a82:	   |   swap d2
	divu	d1, d2          /* high quotient in lower word */
 a84:	   |   divu.w d1,d2
	movew	d2, d0		/* save high quotient */
 a86:	   |   move.w d2,d0
	swap	d0
 a88:	   |   swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
 a8a:	   |   move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
 a8e:	   |   divu.w d1,d2
	movew	d2, d0
 a90:	   |   move.w d2,d0
	jra	6f
 a92:	,--|-- bra.s ac4 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
 a94:	|  '-> move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
 a96:	|  ,-> lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
 a98:	|  |   lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
 a9a:	|  |   cmpi.l #65536,d1
	jcc	4b
 aa0:	|  '-- bcc.s a96 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
 aa2:	|      divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
 aa4:	|      andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
 aaa:	|      move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
 aac:	|      mulu.w d0,d1
	swap	d2
 aae:	|      swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
 ab0:	|      mulu.w d0,d2
	swap	d2		/* align high part with low part */
 ab2:	|      swap d2
	tstw	d2		/* high part 17 bits? */
 ab4:	|      tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
 ab6:	|  ,-- bne.s ac2 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
 ab8:	|  |   add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
 aba:	|  +-- bcs.s ac2 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
 abc:	|  |   cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
 ac0:	+--|-- bls.s ac4 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
 ac2:	|  '-> subq.l #1,d0

6:	movel	sp@+, d2
 ac4:	'----> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
 ac6:	       rts

00000ac8 <__umodsi3>:
	.section .text.__umodsi3,"ax",@progbits
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
 ac8:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
 acc:	move.l 4(sp),d0
	movel	d1, sp@-
 ad0:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 ad2:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
 ad4:	jsr a6c <__udivsi3>
	addql	#8, sp
 ada:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
 adc:	move.l 8(sp),d1
	movel	d1, sp@-
 ae0:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 ae2:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
 ae4:	jsr a4a <__mulsi3>
	addql	#8, sp
 aea:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
 aec:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
 af0:	sub.l d0,d1
	movel	d1, d0
 af2:	move.l d1,d0
	rts
 af4:	rts

00000af6 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
 af6:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
 af8:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
 afc:	jsr -516(a6)
    move.l (sp)+, a6
 b00:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
 b02:	rts

00000b04 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
 b04:	move.b d0,(a3)+
	rts
 b06:	rts
