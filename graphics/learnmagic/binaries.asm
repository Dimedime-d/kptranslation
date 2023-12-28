; customcode.asm now pulls from the labels here.

.org 0x080258B0
.region 0x08028C20-.,00 ; original space taken by old magic SJIS instructions + ascii names
.endregion

.org 0x081C6948
.region 0x081D3D08-.,00 ; original space taken up by preview graphics
.endregion

.org 0x0828C934
.region 0x08297EC4-.,00 ; original space taken by 88x88 helper images
.endregion 

@MagicLearn equ "graphics\learnmagic\dumps\\"

.macro ImageObjHeader,palette
    .byte   0x09,palette,0x2C,0x2C, \
            0xD4,0xD4,0x44,0x10, \
            0xF4,0xD4,0x44,0x10, \
            0x14,0xD4,0x44,0x10, \
            0xD4,0xF4,0x44,0x10, \
            0xF4,0xF4,0x44,0x10, \
            0x14,0xF4,0x44,0x10, \
            0xD4,0x14,0x44,0x10, \
            0xF4,0x14,0x44,0x10, \
            0x14,0x14,0x44,0x10 
.endmacro

.autoregion
    .align
    TableMagicInstructions:
        .word @KururinShockInstructions
        .word @TenAndHundredInstructions
        .word @BookTestInstructions
        .word @TimeParadoxInstructions
        .word @SoundCatchInstructions
        .word @CenterPointInstructions
        .word @GameBoyPanicInstructions
        .word @ImpressionInstructions
        .word @TwistInstructions
        .word @ImagineInstructions
        .word @LoveTesterInstructions
        .word @CaliforniaFlipInstructions
        .word @DoctorKururinInstructions
        .word @MicrowaveInstructions
        .word @UpDownInstructions
        .word @DontTouchInstructions
    
    @KururinShockInstructions:
        .word @KururinShockStep1Set
        .word @KururinShockStep1Map
        .word @KururinShockStep2Set
        .word @KururinShockStep2Map
        .word @KururinShockStep3Set
        .word @KururinShockStep3Map
        .word @KururinShockStep4Set
        .word @KururinShockStep4Map
        .word @KururinShockStep5Set
        .word @KururinShockStep5Map
        .word @KururinShockStep6Set
        .word @KururinShockStep6Map
        .word @KururinShockStep7Set
        .word @KururinShockStep7Map
        .word 0x00
    @TenAndHundredInstructions:
        .word @TenAndHundredStep1Set
        .word @TenAndHundredStep1Map
        .word @TenAndHundredStep2Set
        .word @TenAndHundredStep2Map
        .word @TenAndHundredStep3Set
        .word @TenAndHundredStep3Map
        .word @TenAndHundredStep4Set
        .word @TenAndHundredStep4Map
        .word @TenAndHundredStep5Set
        .word @TenAndHundredStep5Map
        .word @TenAndHundredStep6Set
        .word @TenAndHundredStep6Map
        .word @TenAndHundredStep7Set
        .word @TenAndHundredStep7Map
        .word @TenAndHundredStep8Set
        .word @TenAndHundredStep8Map
        .word @TenAndHundredStep9Set
        .word @TenAndHundredStep9Map
        .word 0x00
    @BookTestInstructions:
        .word @BookTestStep1Set
        .word @BookTestStep1Map
        .word @BookTestStep2Set
        .word @BookTestStep2Map
        .word @BookTestStep3Set
        .word @BookTestStep3Map
        .word @BookTestStep4Set
        .word @BookTestStep4Map
        .word @BookTestStep5Set
        .word @BookTestStep5Map
        .word @BookTestStep6Set
        .word @BookTestStep6Map
        .word @BookTestStep7Set
        .word @BookTestStep7Map
        .word @BookTestStep8Set
        .word @BookTestStep8Map
        .word @BookTestStep9Set
        .word @BookTestStep9Map
        .word @BookTestStep10Set
        .word @BookTestStep10Map
        .word @BookTestStep11Set
        .word @BookTestStep11Map
        .word @BookTestStep12Set
        .word @BookTestStep12Map
        .word 0x00
    @TimeParadoxInstructions:
        .word @TimeParadoxStep1Set
        .word @TimeParadoxStep1Map
        .word @TimeParadoxStep2Set
        .word @TimeParadoxStep2Map
        .word @TimeParadoxStep3Set
        .word @TimeParadoxStep3Map
        .word @TimeParadoxStep4Set
        .word @TimeParadoxStep4Map
        .word @TimeParadoxStep5Set
        .word @TimeParadoxStep5Map
        .word @TimeParadoxStep6Set
        .word @TimeParadoxStep6Map
        .word @TimeParadoxStep7Set
        .word @TimeParadoxStep7Map
        .word 0x00
    @SoundCatchInstructions:
        .word @SoundCatchStep1Set
        .word @SoundCatchStep1Map
        .word @SoundCatchStep2Set
        .word @SoundCatchStep2Map
        .word @SoundCatchStep3Set
        .word @SoundCatchStep3Map
        .word @SoundCatchStep4Set
        .word @SoundCatchStep4Map
        .word @SoundCatchStep5Set
        .word @SoundCatchStep5Map
        .word 0x00
    @CenterPointInstructions:
        .word @CenterPointStep1Set
        .word @CenterPointStep1Map
        .word @CenterPointStep2Set
        .word @CenterPointStep2Map
        .word @CenterPointStep3Set
        .word @CenterPointStep3Map
        .word @CenterPointStep4Set
        .word @CenterPointStep4Map
        .word @CenterPointStep5Set
        .word @CenterPointStep5Map
        .word 0x00
    @GameBoyPanicInstructions:
        .word @GameBoyPanicStep1Set
        .word @GameBoyPanicStep1Map
        .word @GameBoyPanicStep2Set
        .word @GameBoyPanicStep2Map
        .word @GameBoyPanicStep3Set
        .word @GameBoyPanicStep3Map
        .word @GameBoyPanicStep4Set
        .word @GameBoyPanicStep4Map
        .word @GameBoyPanicStep5Set
        .word @GameBoyPanicStep5Map
        .word @GameBoyPanicStep6Set
        .word @GameBoyPanicStep6Map
        .word @GameBoyPanicStep7Set
        .word @GameBoyPanicStep7Map
        .word 0x00
    @ImpressionInstructions:
        .word @ImpressionStep1Set
        .word @ImpressionStep1Map
        .word @ImpressionStep2Set
        .word @ImpressionStep2Map
        .word @ImpressionStep3Set
        .word @ImpressionStep3Map
        .word @ImpressionStep4Set
        .word @ImpressionStep4Map
        .word @ImpressionStep5Set
        .word @ImpressionStep5Map
        .word @ImpressionStep6Set
        .word @ImpressionStep6Map
        .word 0x00
    @TwistInstructions:
        .word @TwistStep1Set
        .word @TwistStep1Map
        .word @TwistStep2Set
        .word @TwistStep2Map
        .word @TwistStep3Set
        .word @TwistStep3Map
        .word @TwistStep4Set
        .word @TwistStep4Map
        .word @TwistStep5Set
        .word @TwistStep5Map
        .word 0x00
    @ImagineInstructions:
        .word @ImagineStep1Set
        .word @ImagineStep1Map
        .word @ImagineStep2Set
        .word @ImagineStep2Map
        .word @ImagineStep3Set
        .word @ImagineStep3Map
        .word @ImagineStep4Set
        .word @ImagineStep4Map
        .word @ImagineStep5Set
        .word @ImagineStep5Map
        .word @ImagineStep6Set
        .word @ImagineStep6Map
        .word 0x00
    @LoveTesterInstructions:
        .word @LoveTesterStep1Set
        .word @LoveTesterStep1Map
        .word @LoveTesterStep2Set
        .word @LoveTesterStep2Map
        .word @LoveTesterStep3Set
        .word @LoveTesterStep3Map
        .word @LoveTesterStep4Set
        .word @LoveTesterStep4Map
        .word 0x00
    @CaliforniaFlipInstructions:
        .word @CaliforniaFlipStep1Set
        .word @CaliforniaFlipStep1Map
        .word @CaliforniaFlipStep2Set
        .word @CaliforniaFlipStep2Map
        .word @CaliforniaFlipStep3Set
        .word @CaliforniaFlipStep3Map
        .word @CaliforniaFlipStep4Set
        .word @CaliforniaFlipStep4Map
        .word @CaliforniaFlipStep5Set
        .word @CaliforniaFlipStep5Map
        .word 0x00
    @DoctorKururinInstructions:
        .word @DoctorKururinStep1Set
        .word @DoctorKururinStep1Map
        .word @DoctorKururinStep2Set
        .word @DoctorKururinStep2Map
        .word @DoctorKururinStep3Set
        .word @DoctorKururinStep3Map
        .word @DoctorKururinStep4Set
        .word @DoctorKururinStep4Map
        .word @DoctorKururinStep5Set
        .word @DoctorKururinStep5Map
        .word 0x00
    @MicrowaveInstructions:
        .word @MicrowaveStep1Set
        .word @MicrowaveStep1Map
        .word @MicrowaveStep2Set
        .word @MicrowaveStep2Map
        .word @MicrowaveStep3Set
        .word @MicrowaveStep3Map
        .word @MicrowaveStep4Set
        .word @MicrowaveStep4Map
        .word @MicrowaveStep5Set
        .word @MicrowaveStep5Map
        .word 0x00
    @UpDownInstructions:
        .word @UpDownStep1Set
        .word @UpDownStep1Map
        .word @UpDownStep2Set
        .word @UpDownStep2Map
        .word @UpDownStep3Set
        .word @UpDownStep3Map
        .word @UpDownStep4Set
        .word @UpDownStep4Map
        .word @UpDownStep5Set
        .word @UpDownStep5Map
        .word @UpDownStep6Set
        .word @UpDownStep6Map
        .word 0x00
    @DontTouchInstructions:
        .word @DontTouchStep1Set
        .word @DontTouchStep1Map
        .word @DontTouchStep2Set
        .word @DontTouchStep2Map
        .word @DontTouchStep3Set
        .word @DontTouchStep3Map
        .word @DontTouchStep4Set
        .word @DontTouchStep4Map
        .word @DontTouchStep5Set
        .word @DontTouchStep5Map
        .word @DontTouchStep6Set
        .word @DontTouchStep6Map
        .word 0x00
        
.endautoregion
        
.autoregion
    .align
    @KururinShockStep1Set:  ::  .incbin @MagicLearn + "1,1.set.dmp" ::  .align
    @KururinShockStep1Map:  ::  .incbin @MagicLearn + "1,1.map.dmp" ::  .align
    @KururinShockStep2Set:  ::  .incbin @MagicLearn + "1,2.set.dmp" ::  .align
    @KururinShockStep2Map:  ::  .incbin @MagicLearn + "1,2.map.dmp" ::  .align
    @KururinShockStep3Set:  ::  .incbin @MagicLearn + "1,3.set.dmp" ::  .align
    @KururinShockStep3Map:  ::  .incbin @MagicLearn + "1,3.map.dmp" ::  .align
    @KururinShockStep4Set:  ::  .incbin @MagicLearn + "1,4.set.dmp" ::  .align
    @KururinShockStep4Map:  ::  .incbin @MagicLearn + "1,4.map.dmp" ::  .align
    @KururinShockStep5Set:  ::  .incbin @MagicLearn + "1,5.set.dmp" ::  .align
    @KururinShockStep5Map:  ::  .incbin @MagicLearn + "1,5.map.dmp" ::  .align
    @KururinShockStep6Set:  ::  .incbin @MagicLearn + "1,6.set.dmp" ::  .align
    @KururinShockStep6Map:  ::  .incbin @MagicLearn + "1,6.map.dmp" ::  .align
    @KururinShockStep7Set:  ::  .incbin @MagicLearn + "1,7.set.dmp" ::  .align
    @KururinShockStep7Map:  ::  .incbin @MagicLearn + "1,7.map.dmp" ::  .align
.endautoregion

.autoregion
    .align
    @TenAndHundredStep1Set:  ::  .incbin @MagicLearn + "2,1.set.dmp" ::  .align
    @TenAndHundredStep1Map:  ::  .incbin @MagicLearn + "2,1.map.dmp" ::  .align
    @TenAndHundredStep2Set:  ::  .incbin @MagicLearn + "2,2.set.dmp" ::  .align
    @TenAndHundredStep2Map:  ::  .incbin @MagicLearn + "2,2.map.dmp" ::  .align
    @TenAndHundredStep3Set:  ::  .incbin @MagicLearn + "2,3.set.dmp" ::  .align
    @TenAndHundredStep3Map:  ::  .incbin @MagicLearn + "2,3.map.dmp" ::  .align
    @TenAndHundredStep4Set:  ::  .incbin @MagicLearn + "2,4.set.dmp" ::  .align
    @TenAndHundredStep4Map:  ::  .incbin @MagicLearn + "2,4.map.dmp" ::  .align
    @TenAndHundredStep5Set:  ::  .incbin @MagicLearn + "2,5.set.dmp" ::  .align
    @TenAndHundredStep5Map:  ::  .incbin @MagicLearn + "2,5.map.dmp" ::  .align
    @TenAndHundredStep6Set:  ::  .incbin @MagicLearn + "2,6.set.dmp" ::  .align
    @TenAndHundredStep6Map:  ::  .incbin @MagicLearn + "2,6.map.dmp" ::  .align
    @TenAndHundredStep7Set:  ::  .incbin @MagicLearn + "2,7.set.dmp" ::  .align
    @TenAndHundredStep7Map:  ::  .incbin @MagicLearn + "2,7.map.dmp" ::  .align
    @TenAndHundredStep8Set:  ::  .incbin @MagicLearn + "2,8.set.dmp" ::  .align
    @TenAndHundredStep8Map:  ::  .incbin @MagicLearn + "2,8.map.dmp" ::  .align
    @TenAndHundredStep9Set:  ::  .incbin @MagicLearn + "2,9.set.dmp" ::  .align
    @TenAndHundredStep9Map:  ::  .incbin @MagicLearn + "2,9.map.dmp" ::  .align
.endautoregion

.autoregion
    .align
    @BookTestStep1Set:      ::  .incbin @MagicLearn + "3,1.set.dmp" ::  .align
    @BookTestStep1Map:      ::  .incbin @MagicLearn + "3,1.map.dmp" ::  .align
    @BookTestStep2Set:      ::  .incbin @MagicLearn + "3,2.set.dmp" ::  .align
    @BookTestStep2Map:      ::  .incbin @MagicLearn + "3,2.map.dmp" ::  .align
    @BookTestStep3Set:      ::  .incbin @MagicLearn + "3,3.set.dmp" ::  .align
    @BookTestStep3Map:      ::  .incbin @MagicLearn + "3,3.map.dmp" ::  .align
    @BookTestStep4Set:      ::  .incbin @MagicLearn + "3,4.set.dmp" ::  .align
    @BookTestStep4Map:      ::  .incbin @MagicLearn + "3,4.map.dmp" ::  .align
    @BookTestStep5Set:      ::  .incbin @MagicLearn + "3,5.set.dmp" ::  .align
    @BookTestStep5Map:      ::  .incbin @MagicLearn + "3,5.map.dmp" ::  .align
    @BookTestStep6Set:      ::  .incbin @MagicLearn + "3,6.set.dmp" ::  .align
    @BookTestStep6Map:      ::  .incbin @MagicLearn + "3,6.map.dmp" ::  .align
    @BookTestStep7Set:      ::  .incbin @MagicLearn + "3,7.set.dmp" ::  .align
    @BookTestStep7Map:      ::  .incbin @MagicLearn + "3,7.map.dmp" ::  .align
    @BookTestStep8Set:      ::  .incbin @MagicLearn + "3,8.set.dmp" ::  .align
    @BookTestStep8Map:      ::  .incbin @MagicLearn + "3,8.map.dmp" ::  .align
    @BookTestStep9Set:      ::  .incbin @MagicLearn + "3,9.set.dmp" ::  .align
    @BookTestStep9Map:      ::  .incbin @MagicLearn + "3,9.map.dmp" ::  .align
    @BookTestStep10Set:      ::  .incbin @MagicLearn + "3,10.set.dmp" ::  .align
    @BookTestStep10Map:      ::  .incbin @MagicLearn + "3,10.map.dmp" ::  .align
    @BookTestStep11Set:      ::  .incbin @MagicLearn + "3,11.set.dmp" ::  .align
    @BookTestStep11Map:      ::  .incbin @MagicLearn + "3,11.map.dmp" ::  .align
    @BookTestStep12Set:      ::  .incbin @MagicLearn + "3,12.set.dmp" ::  .align
    @BookTestStep12Map:      ::  .incbin @MagicLearn + "3,12.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @TimeParadoxStep1Set:      ::  .incbin @MagicLearn + "4,1.set.dmp" ::  .align
    @TimeParadoxStep1Map:      ::  .incbin @MagicLearn + "4,1.map.dmp" ::  .align
    @TimeParadoxStep2Set:      ::  .incbin @MagicLearn + "4,2.set.dmp" ::  .align
    @TimeParadoxStep2Map:      ::  .incbin @MagicLearn + "4,2.map.dmp" ::  .align
    @TimeParadoxStep3Set:      ::  .incbin @MagicLearn + "4,3.set.dmp" ::  .align
    @TimeParadoxStep3Map:      ::  .incbin @MagicLearn + "4,3.map.dmp" ::  .align
    @TimeParadoxStep4Set:      ::  .incbin @MagicLearn + "4,4.set.dmp" ::  .align
    @TimeParadoxStep4Map:      ::  .incbin @MagicLearn + "4,4.map.dmp" ::  .align
    @TimeParadoxStep5Set:      ::  .incbin @MagicLearn + "4,5.set.dmp" ::  .align
    @TimeParadoxStep5Map:      ::  .incbin @MagicLearn + "4,5.map.dmp" ::  .align
    @TimeParadoxStep6Set:      ::  .incbin @MagicLearn + "4,6.set.dmp" ::  .align
    @TimeParadoxStep6Map:      ::  .incbin @MagicLearn + "4,6.map.dmp" ::  .align
    @TimeParadoxStep7Set:      ::  .incbin @MagicLearn + "4,7.set.dmp" ::  .align
    @TimeParadoxStep7Map:      ::  .incbin @MagicLearn + "4,7.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @SoundCatchStep1Set:      ::  .incbin @MagicLearn + "5,1.set.dmp" ::  .align
    @SoundCatchStep1Map:      ::  .incbin @MagicLearn + "5,1.map.dmp" ::  .align
    @SoundCatchStep2Set:      ::  .incbin @MagicLearn + "5,2.set.dmp" ::  .align
    @SoundCatchStep2Map:      ::  .incbin @MagicLearn + "5,2.map.dmp" ::  .align
    @SoundCatchStep3Set:      ::  .incbin @MagicLearn + "5,3.set.dmp" ::  .align
    @SoundCatchStep3Map:      ::  .incbin @MagicLearn + "5,3.map.dmp" ::  .align
    @SoundCatchStep4Set:      ::  .incbin @MagicLearn + "5,4.set.dmp" ::  .align
    @SoundCatchStep4Map:      ::  .incbin @MagicLearn + "5,4.map.dmp" ::  .align
    @SoundCatchStep5Set:      ::  .incbin @MagicLearn + "5,5.set.dmp" ::  .align
    @SoundCatchStep5Map:      ::  .incbin @MagicLearn + "5,5.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @CenterPointStep1Set:      ::  .incbin @MagicLearn + "6,1.set.dmp" ::  .align
    @CenterPointStep1Map:      ::  .incbin @MagicLearn + "6,1.map.dmp" ::  .align
    @CenterPointStep2Set:      ::  .incbin @MagicLearn + "6,2.set.dmp" ::  .align
    @CenterPointStep2Map:      ::  .incbin @MagicLearn + "6,2.map.dmp" ::  .align
    @CenterPointStep3Set:      ::  .incbin @MagicLearn + "6,3.set.dmp" ::  .align
    @CenterPointStep3Map:      ::  .incbin @MagicLearn + "6,3.map.dmp" ::  .align
    @CenterPointStep4Set:      ::  .incbin @MagicLearn + "6,4.set.dmp" ::  .align
    @CenterPointStep4Map:      ::  .incbin @MagicLearn + "6,4.map.dmp" ::  .align
    @CenterPointStep5Set:      ::  .incbin @MagicLearn + "6,5.set.dmp" ::  .align
    @CenterPointStep5Map:      ::  .incbin @MagicLearn + "6,5.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @GameBoyPanicStep1Set:      ::  .incbin @MagicLearn + "7,1.set.dmp" ::  .align
    @GameBoyPanicStep1Map:      ::  .incbin @MagicLearn + "7,1.map.dmp" ::  .align
    @GameBoyPanicStep2Set:      ::  .incbin @MagicLearn + "7,2.set.dmp" ::  .align
    @GameBoyPanicStep2Map:      ::  .incbin @MagicLearn + "7,2.map.dmp" ::  .align
    @GameBoyPanicStep3Set:      ::  .incbin @MagicLearn + "7,3.set.dmp" ::  .align
    @GameBoyPanicStep3Map:      ::  .incbin @MagicLearn + "7,3.map.dmp" ::  .align
    @GameBoyPanicStep4Set:      ::  .incbin @MagicLearn + "7,4.set.dmp" ::  .align
    @GameBoyPanicStep4Map:      ::  .incbin @MagicLearn + "7,4.map.dmp" ::  .align
    @GameBoyPanicStep5Set:      ::  .incbin @MagicLearn + "7,5.set.dmp" ::  .align
    @GameBoyPanicStep5Map:      ::  .incbin @MagicLearn + "7,5.map.dmp" ::  .align
    @GameBoyPanicStep6Set:      ::  .incbin @MagicLearn + "7,6.set.dmp" ::  .align
    @GameBoyPanicStep6Map:      ::  .incbin @MagicLearn + "7,6.map.dmp" ::  .align
    @GameBoyPanicStep7Set:      ::  .incbin @MagicLearn + "7,7.set.dmp" ::  .align
    @GameBoyPanicStep7Map:      ::  .incbin @MagicLearn + "7,7.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @ImpressionStep1Set:      ::  .incbin @MagicLearn + "8,1.set.dmp" ::  .align
    @ImpressionStep1Map:      ::  .incbin @MagicLearn + "8,1.map.dmp" ::  .align
    @ImpressionStep2Set:      ::  .incbin @MagicLearn + "8,2.set.dmp" ::  .align
    @ImpressionStep2Map:      ::  .incbin @MagicLearn + "8,2.map.dmp" ::  .align
    @ImpressionStep3Set:      ::  .incbin @MagicLearn + "8,3.set.dmp" ::  .align
    @ImpressionStep3Map:      ::  .incbin @MagicLearn + "8,3.map.dmp" ::  .align
    @ImpressionStep4Set:      ::  .incbin @MagicLearn + "8,4.set.dmp" ::  .align
    @ImpressionStep4Map:      ::  .incbin @MagicLearn + "8,4.map.dmp" ::  .align
    @ImpressionStep5Set:      ::  .incbin @MagicLearn + "8,5.set.dmp" ::  .align
    @ImpressionStep5Map:      ::  .incbin @MagicLearn + "8,5.map.dmp" ::  .align
    @ImpressionStep6Set:      ::  .incbin @MagicLearn + "8,6.set.dmp" ::  .align
    @ImpressionStep6Map:      ::  .incbin @MagicLearn + "8,6.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @TwistStep1Set:      ::  .incbin @MagicLearn + "9,1.set.dmp" ::  .align
    @TwistStep1Map:      ::  .incbin @MagicLearn + "9,1.map.dmp" ::  .align
    @TwistStep2Set:      ::  .incbin @MagicLearn + "9,2.set.dmp" ::  .align
    @TwistStep2Map:      ::  .incbin @MagicLearn + "9,2.map.dmp" ::  .align
    @TwistStep3Set:      ::  .incbin @MagicLearn + "9,3.set.dmp" ::  .align
    @TwistStep3Map:      ::  .incbin @MagicLearn + "9,3.map.dmp" ::  .align
    @TwistStep4Set:      ::  .incbin @MagicLearn + "9,4.set.dmp" ::  .align
    @TwistStep4Map:      ::  .incbin @MagicLearn + "9,4.map.dmp" ::  .align
    @TwistStep5Set:      ::  .incbin @MagicLearn + "9,5.set.dmp" ::  .align
    @TwistStep5Map:      ::  .incbin @MagicLearn + "9,5.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @ImagineStep1Set:      ::  .incbin @MagicLearn + "10,1.set.dmp" ::  .align
    @ImagineStep1Map:      ::  .incbin @MagicLearn + "10,1.map.dmp" ::  .align
    @ImagineStep2Set:      ::  .incbin @MagicLearn + "10,2.set.dmp" ::  .align
    @ImagineStep2Map:      ::  .incbin @MagicLearn + "10,2.map.dmp" ::  .align
    @ImagineStep3Set:      ::  .incbin @MagicLearn + "10,3.set.dmp" ::  .align
    @ImagineStep3Map:      ::  .incbin @MagicLearn + "10,3.map.dmp" ::  .align
    @ImagineStep4Set:      ::  .incbin @MagicLearn + "10,4.set.dmp" ::  .align
    @ImagineStep4Map:      ::  .incbin @MagicLearn + "10,4.map.dmp" ::  .align
    @ImagineStep5Set:      ::  .incbin @MagicLearn + "10,5.set.dmp" ::  .align
    @ImagineStep5Map:      ::  .incbin @MagicLearn + "10,5.map.dmp" ::  .align
    @ImagineStep6Set:      ::  .incbin @MagicLearn + "10,6.set.dmp" ::  .align
    @ImagineStep6Map:      ::  .incbin @MagicLearn + "10,6.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @LoveTesterStep1Set:      ::  .incbin @MagicLearn + "11,1.set.dmp" ::  .align
    @LoveTesterStep1Map:      ::  .incbin @MagicLearn + "11,1.map.dmp" ::  .align
    @LoveTesterStep2Set:      ::  .incbin @MagicLearn + "11,2.set.dmp" ::  .align
    @LoveTesterStep2Map:      ::  .incbin @MagicLearn + "11,2.map.dmp" ::  .align
    @LoveTesterStep3Set:      ::  .incbin @MagicLearn + "11,3.set.dmp" ::  .align
    @LoveTesterStep3Map:      ::  .incbin @MagicLearn + "11,3.map.dmp" ::  .align
    @LoveTesterStep4Set:      ::  .incbin @MagicLearn + "11,4.set.dmp" ::  .align
    @LoveTesterStep4Map:      ::  .incbin @MagicLearn + "11,4.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @CaliforniaFlipStep1Set:      ::  .incbin @MagicLearn + "12,1.set.dmp" ::  .align
    @CaliforniaFlipStep1Map:      ::  .incbin @MagicLearn + "12,1.map.dmp" ::  .align
    @CaliforniaFlipStep2Set:      ::  .incbin @MagicLearn + "12,2.set.dmp" ::  .align
    @CaliforniaFlipStep2Map:      ::  .incbin @MagicLearn + "12,2.map.dmp" ::  .align
    @CaliforniaFlipStep3Set:      ::  .incbin @MagicLearn + "12,3.set.dmp" ::  .align
    @CaliforniaFlipStep3Map:      ::  .incbin @MagicLearn + "12,3.map.dmp" ::  .align
    @CaliforniaFlipStep4Set:      ::  .incbin @MagicLearn + "12,4.set.dmp" ::  .align
    @CaliforniaFlipStep4Map:      ::  .incbin @MagicLearn + "12,4.map.dmp" ::  .align
    @CaliforniaFlipStep5Set:      ::  .incbin @MagicLearn + "12,5.set.dmp" ::  .align
    @CaliforniaFlipStep5Map:      ::  .incbin @MagicLearn + "12,5.map.dmp" ::  .align
 .endautoregion

.autoregion
    .align   
    @DoctorKururinStep1Set:      ::  .incbin @MagicLearn + "13,1.set.dmp" ::  .align
    @DoctorKururinStep1Map:      ::  .incbin @MagicLearn + "13,1.map.dmp" ::  .align
    @DoctorKururinStep2Set:      ::  .incbin @MagicLearn + "13,2.set.dmp" ::  .align
    @DoctorKururinStep2Map:      ::  .incbin @MagicLearn + "13,2.map.dmp" ::  .align
    @DoctorKururinStep3Set:      ::  .incbin @MagicLearn + "13,3.set.dmp" ::  .align
    @DoctorKururinStep3Map:      ::  .incbin @MagicLearn + "13,3.map.dmp" ::  .align
    @DoctorKururinStep4Set:      ::  .incbin @MagicLearn + "13,4.set.dmp" ::  .align
    @DoctorKururinStep4Map:      ::  .incbin @MagicLearn + "13,4.map.dmp" ::  .align
    @DoctorKururinStep5Set:      ::  .incbin @MagicLearn + "13,5.set.dmp" ::  .align
    @DoctorKururinStep5Map:      ::  .incbin @MagicLearn + "13,5.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @MicrowaveStep1Set:      ::  .incbin @MagicLearn + "14,1.set.dmp" ::  .align
    @MicrowaveStep1Map:      ::  .incbin @MagicLearn + "14,1.map.dmp" ::  .align
    @MicrowaveStep2Set:      ::  .incbin @MagicLearn + "14,2.set.dmp" ::  .align
    @MicrowaveStep2Map:      ::  .incbin @MagicLearn + "14,2.map.dmp" ::  .align
    @MicrowaveStep3Set:      ::  .incbin @MagicLearn + "14,3.set.dmp" ::  .align
    @MicrowaveStep3Map:      ::  .incbin @MagicLearn + "14,3.map.dmp" ::  .align
    @MicrowaveStep4Set:      ::  .incbin @MagicLearn + "14,4.set.dmp" ::  .align
    @MicrowaveStep4Map:      ::  .incbin @MagicLearn + "14,4.map.dmp" ::  .align
    @MicrowaveStep5Set:      ::  .incbin @MagicLearn + "14,5.set.dmp" ::  .align
    @MicrowaveStep5Map:      ::  .incbin @MagicLearn + "14,5.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @UpDownStep1Set:      ::  .incbin @MagicLearn + "15,1.set.dmp" ::  .align
    @UpDownStep1Map:      ::  .incbin @MagicLearn + "15,1.map.dmp" ::  .align
    @UpDownStep2Set:      ::  .incbin @MagicLearn + "15,2.set.dmp" ::  .align
    @UpDownStep2Map:      ::  .incbin @MagicLearn + "15,2.map.dmp" ::  .align
    @UpDownStep3Set:      ::  .incbin @MagicLearn + "15,3.set.dmp" ::  .align
    @UpDownStep3Map:      ::  .incbin @MagicLearn + "15,3.map.dmp" ::  .align
    @UpDownStep4Set:      ::  .incbin @MagicLearn + "15,4.set.dmp" ::  .align
    @UpDownStep4Map:      ::  .incbin @MagicLearn + "15,4.map.dmp" ::  .align
    @UpDownStep5Set:      ::  .incbin @MagicLearn + "15,5.set.dmp" ::  .align
    @UpDownStep5Map:      ::  .incbin @MagicLearn + "15,5.map.dmp" ::  .align
    @UpDownStep6Set:      ::  .incbin @MagicLearn + "15,6.set.dmp" ::  .align
    @UpDownStep6Map:      ::  .incbin @MagicLearn + "15,6.map.dmp" ::  .align
.endautoregion

.autoregion
    .align    
    @DontTouchStep1Set:      ::  .incbin @MagicLearn + "16,1.set.dmp" ::  .align
    @DontTouchStep1Map:      ::  .incbin @MagicLearn + "16,1.map.dmp" ::  .align
    @DontTouchStep2Set:      ::  .incbin @MagicLearn + "16,2.set.dmp" ::  .align
    @DontTouchStep2Map:      ::  .incbin @MagicLearn + "16,2.map.dmp" ::  .align
    @DontTouchStep3Set:      ::  .incbin @MagicLearn + "16,3.set.dmp" ::  .align
    @DontTouchStep3Map:      ::  .incbin @MagicLearn + "16,3.map.dmp" ::  .align
    @DontTouchStep4Set:      ::  .incbin @MagicLearn + "16,4.set.dmp" ::  .align
    @DontTouchStep4Map:      ::  .incbin @MagicLearn + "16,4.map.dmp" ::  .align
    @DontTouchStep5Set:      ::  .incbin @MagicLearn + "16,5.set.dmp" ::  .align
    @DontTouchStep5Map:      ::  .incbin @MagicLearn + "16,5.map.dmp" ::  .align
    @DontTouchStep6Set:      ::  .incbin @MagicLearn + "16,6.set.dmp" ::  .align
    @DontTouchStep6Map:      ::  .incbin @MagicLearn + "16,6.map.dmp" ::  .align
.endautoregion

.autoregion
    .align
    TableMagicImages:
        .word @KururinShockImages
        .word @TenAndHundredImages
        .word @BookTestImages
        .word @TimeParadoxImages
        .word @SoundCatchImages
        .word @CenterPointImages
        .word @GameBoyPanicImages
        .word @ImpressionImages
        .word @TwistImages
        .word @ImagineImages
        .word @LoveTesterImages
        .word @CaliforniaFlipImages
        .word @DoctorKururinImages
        .word @MicrowaveImages
        .word @UpDownImages
        .word @DontTouchImages
        
    @Terminator equ 0xFF, 0xFF

    ; bytes are page number (0-indexed) and image ID
    @KururinShockImages:
        .byte 0x02, 0x00, @Terminator
    @TenAndHundredImages:
        .byte 0x05, 0x01, @Terminator
    @BookTestImages:
        .byte 0x06, 0x02, @Terminator
    @TimeParadoxImages:
    @SoundCatchImages:
    @CenterPointImages:
    @ImpressionImages:
    @CaliforniaFlipImages:
    @DoctorKururinImages:
    @DontTouchImages:
        .byte @Terminator
    @GameBoyPanicImages:
        .byte 0x04, 0x03, @Terminator
    @TwistImages:
        .byte 0x01, 0x04, @Terminator
    @ImagineImages:
        .byte 0x01, 0x05, @Terminator
    @LoveTesterImages:
        .byte 0x01, 0x06, @Terminator
    @MicrowaveImages:
        .byte 0x02, 0x07, 0x03, 0x08, @Terminator
    @UpDownImages:
        .byte 0x00, 0x09, @Terminator
        
    .align
    @Picture0:
        ImageObjHeader 0x01
        .incbin @MagicLearn + "pic0.dmp"
    .align
    @Picture1:
        ImageObjHeader 0x02
        .incbin @MagicLearn + "pic1.dmp"
    .align
    @Picture2:
        ImageObjHeader 0x03
        .incbin @MagicLearn + "pic2.dmp"
    .align
    @Picture3:
        ImageObjHeader 0x04
        .incbin @MagicLearn + "pic3.dmp"
    .align
    @Picture4:
        ImageObjHeader 0x05
        .incbin @MagicLearn + "pic4.dmp"
    .align
    @Picture5:
        ImageObjHeader 0x06
        .incbin @MagicLearn + "pic5.dmp"
    .align
    @Picture6:
        ImageObjHeader 0x07
        .incbin @MagicLearn + "pic6.dmp"
    .align
    @Picture7:
        ImageObjHeader 0x08
        .incbin @MagicLearn + "pic7.dmp"
    .align
    @Picture8:
        ImageObjHeader 0x09
        .incbin @MagicLearn + "pic8.dmp"
    .align
    @Picture9:
        ImageObjHeader 0x0A
        .incbin @MagicLearn + "pic9.dmp"
    .align
    
    ObjLArrow:
        .byte   0x01,0x0B,0x10,0x08, \
                0xF3,0xF8,0x24,0x08
        .incbin "bin/obj_LArrow.bin"
    ObjRArrow:
        .byte   0x01,0x0B,0x10,0x08, \
                0xF8,0xF8,0x24,0x08
        .incbin "bin/obj_RArrow.bin"
        
    .align
.endautoregion

.autoregion
    .align    
    @Preview0Tiles:
        .incbin @MagicLearn + "preview0tiles.dmp" ::    .align
    @Preview0Map:
        .incbin @MagicLearn + "preview0map.dmp"   ::    .align
    @Preview0Palette:
        .incbin "kp.gba",0x1C7774,0x200           ::    .align
    @Preview1Tiles:
        .incbin @MagicLearn + "preview1tiles.dmp" ::    .align
    @Preview1Map:
        .incbin @MagicLearn + "preview1map.dmp"   ::    .align
    @Preview1Palette:
        .incbin "kp.gba",0x1C85A4,0x200           ::    .align
    @Preview2Tiles:
        .incbin @MagicLearn + "preview2tiles.dmp" ::    .align
    @Preview2Map:
        .incbin @MagicLearn + "preview2map.dmp"   ::    .align
    @Preview2Palette:
        .incbin "kp.gba",0x1C92DC,0x200           ::    .align
    @Preview3Tiles:
        .incbin @MagicLearn + "preview3tiles.dmp" ::    .align
    @Preview3Map:
        .incbin @MagicLearn + "preview3map.dmp"   ::    .align
    @Preview3Palette:
        .incbin "kp.gba",0x1C9EEC,0x200           ::    .align
    @Preview4Tiles:
        .incbin @MagicLearn + "preview4tiles.dmp" ::    .align
    @Preview4Map:
        .incbin @MagicLearn + "preview4map.dmp"   ::    .align
    @Preview4Palette:
        .incbin "kp.gba",0x1CAC08,0x200           ::    .align
    @Preview5Tiles:
        .incbin @MagicLearn + "preview5tiles.dmp" ::    .align
    @Preview5Map:
        .incbin @MagicLearn + "preview5map.dmp"   ::    .align
    @Preview5Palette:
        .incbin "kp.gba",0x1CB928,0x200           ::    .align
    @Preview6Tiles:
        .incbin @MagicLearn + "preview6tiles.dmp" ::    .align
    @Preview6Map:
        .incbin @MagicLearn + "preview6map.dmp"   ::    .align
    @Preview6Palette:
        .incbin "kp.gba",0x1CC4A4,0x200           ::    .align
    @Preview7Tiles:
        .incbin @MagicLearn + "preview7tiles.dmp" ::    .align
    @Preview7Map:
        .incbin @MagicLearn + "preview7map.dmp"   ::    .align
    @Preview7Palette:
        .incbin "kp.gba",0x1CD34C,0x200           ::    .align
    @Preview8Tiles:
        .incbin @MagicLearn + "preview8tiles.dmp" ::    .align
    @Preview8Map:
        .incbin @MagicLearn + "preview8map.dmp"   ::    .align
    @Preview8Palette:
        .incbin "kp.gba",0x1CDF10,0x200           ::    .align
    @Preview9Tiles:
        .incbin @MagicLearn + "preview9tiles.dmp" ::    .align
    @Preview9Map:
        .incbin @MagicLearn + "preview9map.dmp"   ::    .align
    @Preview9Palette:
        .incbin "kp.gba",0x1CEAB8,0x200           ::    .align
    @Preview10Tiles:
        .incbin @MagicLearn + "preview10tiles.dmp" ::    .align
    @Preview10Map:
        .incbin @MagicLearn + "preview10map.dmp"   ::    .align
    @Preview10Palette:
        .incbin "kp.gba",0x1CF8E8,0x200           ::    .align
    @Preview11Tiles:
        .incbin @MagicLearn + "preview11tiles.dmp" ::    .align
    @Preview11Map:
        .incbin @MagicLearn + "preview11map.dmp"   ::    .align
    @Preview11Palette:
        .incbin "kp.gba",0x1D05D8,0x200           ::    .align
    @Preview12Tiles:
        .incbin @MagicLearn + "preview12tiles.dmp" ::    .align
    @Preview12Map:
        .incbin @MagicLearn + "preview12map.dmp"   ::    .align
    @Preview12Palette:
        .incbin "kp.gba",0x1D141C,0x200           ::    .align
    @Preview13Tiles:
        .incbin @MagicLearn + "preview13tiles.dmp" ::    .align
    @Preview13Map:
        .incbin @MagicLearn + "preview13map.dmp"   ::    .align
    @Preview13Palette:
        .incbin "kp.gba",0x1D1FEC,0x200           ::    .align
    @Preview14Tiles:
        .incbin @MagicLearn + "preview14tiles.dmp" ::    .align
    @Preview14Map:
        .incbin @MagicLearn + "preview14map.dmp"   ::    .align
    @Preview14Palette:
        .incbin "kp.gba",0x1D2E90,0x200           ::    .align
    @Preview15Tiles:
        .incbin @MagicLearn + "preview15tiles.dmp" ::    .align
    @Preview15Map:
        .incbin @MagicLearn + "preview15map.dmp"   ::    .align
    @Preview15Palette:
        .incbin "kp.gba",0x1D3B08,0x200           ::    .align
.endautoregion

.autoregion
    .align         
    @Header0Tiles:
        .incbin @MagicLearn + "header0tiles.dmp"    ::  .align
    @Header0Map:
        .incbin @MagicLearn + "header0map.dmp"      ::  .align        
    @Header1Tiles:
        .incbin @MagicLearn + "header1tiles.dmp"    ::  .align
    @Header1Map:
        .incbin @MagicLearn + "header1map.dmp"      ::  .align        
    @Header2Tiles:
        .incbin @MagicLearn + "header2tiles.dmp"    ::  .align
    @Header2Map:
        .incbin @MagicLearn + "header2map.dmp"      ::  .align        
    @Header3Tiles:
        .incbin @MagicLearn + "header3tiles.dmp"    ::  .align
    @Header3Map:
        .incbin @MagicLearn + "header3map.dmp"      ::  .align        
    @Header4Tiles:
        .incbin @MagicLearn + "header4tiles.dmp"    ::  .align
    @Header4Map:
        .incbin @MagicLearn + "header4map.dmp"      ::  .align        
    @Header5Tiles:
        .incbin @MagicLearn + "header5tiles.dmp"    ::  .align
    @Header5Map:
        .incbin @MagicLearn + "header5map.dmp"      ::  .align        
    @Header6Tiles:
        .incbin @MagicLearn + "header6tiles.dmp"    ::  .align
    @Header6Map:
        .incbin @MagicLearn + "header6map.dmp"      ::  .align        
    @Header7Tiles:
        .incbin @MagicLearn + "header7tiles.dmp"    ::  .align
    @Header7Map:
        .incbin @MagicLearn + "header7map.dmp"      ::  .align        
    @Header8Tiles:
        .incbin @MagicLearn + "header8tiles.dmp"    ::  .align
    @Header8Map:
        .incbin @MagicLearn + "header8map.dmp"      ::  .align        
    @Header9Tiles:
        .incbin @MagicLearn + "header9tiles.dmp"    ::  .align
    @Header9Map:
        .incbin @MagicLearn + "header9map.dmp"      ::  .align        
    @Header10Tiles:
        .incbin @MagicLearn + "header10tiles.dmp"    ::  .align
    @Header10Map:
        .incbin @MagicLearn + "header10map.dmp"      ::  .align        
    @Header11Tiles:
        .incbin @MagicLearn + "header11tiles.dmp"    ::  .align
    @Header11Map:
        .incbin @MagicLearn + "header11map.dmp"      ::  .align        
    @Header12Tiles:
        .incbin @MagicLearn + "header12tiles.dmp"    ::  .align
    @Header12Map:
        .incbin @MagicLearn + "header12map.dmp"      ::  .align        
    @Header13Tiles:
        .incbin @MagicLearn + "header13tiles.dmp"    ::  .align
    @Header13Map:
        .incbin @MagicLearn + "header13map.dmp"      ::  .align        
    @Header14Tiles:
        .incbin @MagicLearn + "header14tiles.dmp"    ::  .align
    @Header14Map:
        .incbin @MagicLearn + "header14map.dmp"      ::  .align        
    @Header15Tiles:
        .incbin @MagicLearn + "header15tiles.dmp"    ::  .align
    @Header15Map:
        .incbin @MagicLearn + "header15map.dmp"      ::  .align
.endautoregion

.autoregion
    .align        
    ; this table is NOT in the original ROM (the headers used to be all 1 tileset), so it must be in the autoregion as a global variable
    MagicHeaderTable:
        .word @Header0Tiles
        .word @Header0Map
        .word @Header1Tiles
        .word @Header1Map
        .word @Header2Tiles
        .word @Header2Map
        .word @Header3Tiles
        .word @Header3Map
        .word @Header4Tiles
        .word @Header4Map
        .word @Header5Tiles
        .word @Header5Map
        .word @Header6Tiles
        .word @Header6Map
        .word @Header7Tiles
        .word @Header7Map
        .word @Header8Tiles
        .word @Header8Map
        .word @Header9Tiles
        .word @Header9Map
        .word @Header10Tiles
        .word @Header10Map
        .word @Header11Tiles
        .word @Header11Map
        .word @Header12Tiles
        .word @Header12Map
        .word @Header13Tiles
        .word @Header13Map
        .word @Header14Tiles
        .word @Header14Map
        .word @Header15Tiles
        .word @Header15Map
    
    .align
    
    @TrickTenHundredObj: ; juuust too big to fit in original space (7AB35C -> 7AC390), unfortunately
        .incbin "bin/tenhundredobjnew.bin"
        
    .align
    
    @TrickTimeTiles: ; also just too big (7AE184 -> 7AE84C)
        .incbin "bin/timenewtiles.bin"
    
.endautoregion

; repointing picture data
.org 0x0803C1FC
    .word @Picture0 ; Kururin Shock - GBA with ticker
    .word @Picture1 ; ten and hundred GBA press
    .word @Picture2 ; book test slots
    .word @Picture3 ; gameboy panic hold
    .word @Picture4 ; twist parallel lines
    .word @Picture5 ; imagine speak while pushing
    .word @Picture6 ; love tester
    .word @Picture7 ; matchstick 1
    .word @Picture8 ; matchstick 2
    .word @Picture9 ; up down facing each other
    
; repointing preview data
.org 0x0803C0BC
    .word @Preview0Tiles
    .word @Preview0Map
    .word @Preview0Palette ; palette unchanged, just changing the location and freeing the original space
    .word @Preview1Tiles
    .word @Preview1Map
    .word @Preview1Palette
    .word @Preview2Tiles
    .word @Preview2Map
    .word @Preview2Palette
    .word @Preview3Tiles
    .word @Preview3Map
    .word @Preview3Palette
    .word @Preview4Tiles
    .word @Preview4Map
    .word @Preview4Palette
    .word @Preview5Tiles
    .word @Preview5Map
    .word @Preview5Palette
    .word @Preview6Tiles
    .word @Preview6Map
    .word @Preview6Palette
    .word @Preview7Tiles
    .word @Preview7Map
    .word @Preview7Palette
    .word @Preview8Tiles
    .word @Preview8Map
    .word @Preview8Palette
    .word @Preview9Tiles
    .word @Preview9Map
    .word @Preview9Palette
    .word @Preview10Tiles
    .word @Preview10Map
    .word @Preview10Palette
    .word @Preview11Tiles
    .word @Preview11Map
    .word @Preview11Palette
    .word @Preview12Tiles
    .word @Preview12Map
    .word @Preview12Palette
    .word @Preview13Tiles
    .word @Preview13Map
    .word @Preview13Palette
    .word @Preview14Tiles
    .word @Preview14Map
    .word @Preview14Palette
    .word @Preview15Tiles
    .word @Preview15Map
    .word @Preview15Palette
    
; repointing initial preview palette (prevent screen flash for a frame)
.org 0x08022504
    .word @Preview0Palette - 0x08139454
    
;===========Misc. Magic tricks==============

.org 0x0879EE58
    .word @TrickTenHundredObj
    
.org 0x087AAEB4
.area 0x087AB35C-.
    .incbin @MagicLearn + "tenhundredtiles.dmp"
.endarea
    
.org 0x087AC4F8
.area 0x087AC654-.
    .incbin @MagicLearn + "tenhundredintromap.dmp"
.endarea
    
.org 0x087AC390
.area 0x087AC4F8-.
    .incbin @MagicLearn + "tenhundredcoinmap.dmp"
.endarea

; repositioning sprite text in ten and hundred
.org 0x0879F30A
    mov r2, 0x50 ; "10"/"100" text
    mov r3, 0x6A
    
.org 0x0879F364
    mov r2, 0x50
    mov r3, 0x6A
    
.org 0x0879F320
    mov r2, 0x68
    mov r3, 0x7A

.org 0x0879F348
    mov r2, 0x68
    mov r3, 0x7A
    
.org 0x0879F3A8
    mov r2, 0x68
    mov r3, 0x7A
    
.org 0x0879F37A
    mov r2, 0x68
    mov r3, 0x7A
    
.org 0x087AC718 ::  .byte 0x58
.org 0x087AC728 ::  .byte 0x5C ; I switched heads and tails lol
    
; book test
.org 0x087AC7F4
.area 0x087ACE8C-.
    .incbin "bin/booktestnewtiles.bin"
.endarea

.org 0x087AD96C
.area 0x087ADAD4-.
    .incbin @MagicLearn + "booktestmap1.dmp"
.endarea

.org 0x087ADAD4
.area 0x087ADC24-.
    .incbin @MagicLearn + "booktestmap2.dmp"
.endarea

.org 0x087ADC24
.area 0x087ADD64-.
    .incbin @MagicLearn + "booktestmap3.dmp"
.endarea

.org 0x0879FF60
    .word @TrickTimeTiles
    
.org 0x087AF140
    .incbin @MagicLearn + "timemap.dmp"
    
.org 0x087AF68C
.area 0x087B61C8-.
    .incbin "bin/soundcatchnewobj.bin"
.endarea    

.org 0x087B16B4
.area 0x087B1C64-.
    .incbin "bin/centerpointnewtiles.bin"
.endarea

.org 0x087B2170
.area 0x087B22C0-.
    .incbin @MagicLearn + "centerpointmap.dmp"
.endarea

.org 0x087B5DE0
.area 0x1C3C
    .incbin @MagicLearn + "imaginebitmap.dmp"
.endarea

; don't touch
.org 0x087C1658
.area 0x087C3910-.
    .incbin "bin/donttouchnewtiles.bin"
.endarea

.org 0x087C22F0
    .incbin @MagicLearn + "donttouchmap.dmp"
    
    
    
    
    
    
    
    