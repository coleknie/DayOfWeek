 .ORIG x3000


    
    AND R0, R0, #0
    LDI R0, YEAR 
    AND R1, R1, #0 ;Day of Week the Day before January 1 1900 was sunday
    ADD R1, R1, #1
    
    AND R3, R3, #0
    
    LD R3, YEAR1900
    ADD R3, R3, #0
    ADD R3, R3, #1 
    NOT R3, R3
    ADD R3, R3, #1
    
    AND R2, R2, #0
    ADD R2, R0, R2
    
    ADD R2, R0, R3

    BR START_YEAR_INC


;this coad block starts the YEARINC loop in which we increment years
START_YEAR_INC:
    AND R2,R2, #0; set R2 equal to zero
    ADD R2,R2,R0
    NOT R2,R2
    ADD R2,R2,#1; set to R2 to negative
    
    AND R3, R3, #0
    LD R3, YEAR1900

    BR YEARINC
    
YEARINC:
    ADD R3, R3, #1; Increments Year
    AND R4, R4, #0
    
    AND R2,R2, #0; set R2 equal to zero
    ADD R2,R2,R0
    NOT R2,R2
    ADD R2,R2,#1; set to R2 to negative of R0
    
    ADD R4,R3,R2; R2 is negative of (year), checks if we are up to year
    BRz START_DAY_INC
    
    ADD R1, R1, #1
    
    AND R5, R5, #0
    ADD R5,R5,R3

    LEA R7, YEARINC
    BR LEAP
  
 
;Starts recursive leap year loop  
LEAP:
    AND R6, R6, #0
    LD R6, YEAR1600
    
    NOT R6, R6
    ADD R6, R6, #1
    ADD R5,R5,R6; code block subtracts 1600 from date, facilitates checking if divisble by 400, 100, or 4
    
    AND R6, R6, #0
    ADD R6, R6, R5
    
    AND R4, R4, #0
    ADD R4, R4, #-1

    AND R2, R2, #0
    ;recurses
    BR LEAP_REC
;Recursive Leap Year checks if divisble by 400,100,and 4  
LEAP_REC:
    AND R2, R2, #0
    ADD R4, R4, #0
    BRzp LEAP_REC100
    LD R2, NEG400
    ADD R5, R5, R2; subtract 4
    BRzp #4
    ADD R4, R4, #1
    AND R5, R5, #0
    ADD R5, R5, R6
    BR LEAP_REC
    ADD R5, R5, #0
    BRnp #2
    ADD R1, R1, #1
    BR LEAP_RET
    BR LEAP_REC;;;;;;;;;;;;;;;
LEAP_REC100:
    ADD R4, R4, #0
    BRnp LEAP_REC4
    LD R2, NEG100
    ADD R5, R5, R2; subtract 4
    BRzp #4
    ADD R4, R4, #1
    AND R5, R5, #0
    ADD R5, R5, R6
    BR LEAP_REC
    ADD R5, R5, #0
    BRnp #1
    BR LEAP_RET
    BR LEAP_REC;;;;;;;;;;
LEAP_REC4:
    ADD R5, R5, #-4; subtract 4
    BRp LEAP_REC
    ADD R5,R5,#0
    BRn LEAP_RET
    ADD R1, R1, #1
LEAP_RET:
    JMP R7; PC becomes R7 again

;Starts Incrementing Days in a Month Process
START_DAY_INC:
AND R2, R2, #0
ADD R2, R2, #1

AND R3, R3, #0
LDI R3, MONTH
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR JANUARY

JANUARY:
AND R4, R4, #0
LD R4, D31
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR FEBRUARY

FEBRUARY:
AND R4, R4, #0
LD R4, D28
ADD R1, R1, R4

AND R7, R7, #0
LEA R7, FEBRUARY_
AND R5, R5, #0
LDI R5, YEAR

BR LEAP

FEBRUARY_:
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR MARCH

MARCH:
AND R4, R4, #0
LD R4, D31
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR APRIL

APRIL:
AND R4, R4, #0
LD R4, D30
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR MAY_M

MAY_M:
AND R4, R4, #0
LD R4, D31
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR JUNE

JUNE:
AND R4, R4, #0
LD R4, D30
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR JULY

JULY:
AND R4, R4, #0
LD R4, D31
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR AUGUST

AUGUST:
AND R4, R4, #0
LD R4, D31
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR SEPTEMBER

SEPTEMBER:
AND R4, R4, #0
LD R4, D30
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR OCTOBER

OCTOBER:
AND R4, R4, #0
LD R4, D31
ADD R1, R1, R4
ADD R3, R3, #-1
BRz INSIDE_MONTH
BR NOVEMBER

NOVEMBER:
AND R4, R4, #0
LD R4, D30
ADD R1, R1, R4
ADD R3, R3, #-1
BR INSIDE_MONTH

INSIDE_MONTH:
AND R2, R2, #0
LDI R2, DAYS
ADD R1, R1, R2
ADD R1, R1, #0
ADD R1, R1, #0

;Sets Days equal to Days Mod 7
MOD7DAYS:
ADD R1, R1, #-7
BRp MOD7DAYS
ADD R1, R1, #0
BRz MESSAGE
ADD R1, R1, #7
BR MESSAGE

;Creates Message and stores to memory location
MESSAGE:

STI R1, STORE_x31F3

AND R2, R2, #0
LEA R2, SUN
ADD R1, R1, #0
BRZ PRINT
ADD R1, R1, #-1

AND R2, R2, #0
LEA R2, MON
PUTS
ADD R1, R1, #0
BRZ PRINT
ADD R1, R1, #-1

AND R2, R2, #0
LEA R2, TUE
ADD R1, R1, #0
BRZ PRINT
ADD R1, R1, #-1


AND R2, R2, #0
LEA R2, WED
ADD R1, R1, #0
BRZ PRINT
ADD R1, R1, #-1

AND R2, R2, #0
LEA R2, THR
ADD R1, R1, #0
BRZ PRINT
ADD R1, R1, #-1

AND R2, R2, #0
LEA R2, FRI
ADD R1, R1, #0
BRz PRINT
ADD R1, R1, #-1

AND R2, R2, #0
LEA R2, SAT
ADD R1, R1, #0
BRZ PRINT
ADD R1, R1, #-1

;Prints Message
PRINT:
    AND R0, R0, #0
    LEA R0, Phrase
    PUTS
    AND R0, R0, #0
    ADD R0, R0, R2
    PUTS
;Halts
HALT

;Labels
STORE_x31F3: .FILL x31F3
YEAR: .FILL x31F2
MONTH: .FILL x31F1
DAYS: .FILL x31F0
YEAR1900: .FILL 1900
YEAR1600: .FILL 1600
D28: .FILL 28
D30: .FILL 30
D31: .FILL 31
NEG100: .FILL -100
NEG400:.FILL -400
SAT: .STRINGZ "Saturday."
SUN: .STRINGZ "Sunday."
MON: .STRINGZ "Monday."
TUE: .STRINGZ "Tuesday."
WED: .STRINGZ "Wednesday."
THR: .STRINGZ "Thursday."
FRI: .STRINGZ "Friday."
PHRASE: .STRINGZ "The Day Is "
HALT


.END
    
