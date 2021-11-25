DEF LD  0x80                ; LED adatregiszter            (írható/olvasható)
DEF TR  0x82                ; Timer kezdõállapot regiszter (csak írható)
DEF TM  0x82                ; Timer számláló regiszter     (csak olvasható)
DEF TC  0x83                ; Timer parancs regiszter      (csak írható)
DEF TS  0x83 

START:



    mov r9, #60 ;lefele szamlalunk 60->0, 61db
    mov TR, r9
    mov r9, #0b01110011 ;no IT, max.prescaler, rep., en.
    mov TC, r9   

    mov r0, #0xE0
    
   RIGHT:
   mov LD, r0
   jsr wseven
   sr0 r0
   tst r0, #0x01
   jz RIGHT
   jnz LEFT
   
   LEFT:
   mov LD, r0
   jsr wseven
   sl0 r0
   tst r0, #0x80
   jz LEFT
   jnz RIGHT
   
   
        
   
    


wait: ;software dilay loop  
     mov r10, #0
     mov r11, #0
     mov r12, #0

WAIT_LOOP:
     add r10, #0xFF    ;cntr = cntr + 50
     adc r11, #0
     adc r12, #0
     jnc WAIT_LOOP
     
     
     rts

   
 wseven:
    mov r8, TS
    tst r8,#0x04 ;test 4 TOUT
    jz wseven
    rts 
