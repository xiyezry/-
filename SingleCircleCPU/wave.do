onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /Mips/zero
add wave -noupdate -radix hexadecimal /Mips/rst
add wave -noupdate -radix hexadecimal /Mips/overflow
add wave -noupdate -radix hexadecimal /Mips/op
add wave -noupdate -radix hexadecimal /Mips/negative
add wave -noupdate -radix hexadecimal /Mips/funct
add wave -noupdate -radix hexadecimal /Mips/clk
add wave -noupdate -radix hexadecimal /Mips/carry
add wave -noupdate -radix hexadecimal /Mips/ShifterOut
add wave -noupdate -radix hexadecimal /Mips/ShifterIndex
add wave -noupdate -radix hexadecimal /Mips/ShifterIn
add wave -noupdate -radix hexadecimal /Mips/ShiftIndex
add wave -noupdate -radix hexadecimal /Mips/ShiftDirection
add wave -noupdate -radix hexadecimal /Mips/SArith
add wave -noupdate -radix hexadecimal /Mips/RegWrite
add wave -noupdate -radix hexadecimal /Mips/RegDst
add wave -noupdate -radix hexadecimal /Mips/RFWS
add wave -noupdate -radix hexadecimal /Mips/RFR2
add wave -noupdate -radix hexadecimal /Mips/RFR1
add wave -noupdate -radix hexadecimal /Mips/RFDataOut2
add wave -noupdate -radix hexadecimal /Mips/RFDataOut1
add wave -noupdate -radix hexadecimal /Mips/RFDataIn
add wave -noupdate -radix hexadecimal /Mips/PC
add wave -noupdate -radix hexadecimal /Mips/NPCOp
add wave -noupdate -radix hexadecimal /Mips/NPC
add wave -noupdate -radix hexadecimal /Mips/MemWrite
add wave -noupdate -radix hexadecimal /Mips/MemToReg
add wave -noupdate -radix hexadecimal /Mips/MemRead
add wave -noupdate -radix hexadecimal /Mips/Ins
add wave -noupdate -radix hexadecimal /Mips/IMAdd
add wave -noupdate -radix hexadecimal /Mips/EXTOP
add wave -noupdate -radix hexadecimal /Mips/EXTDataOut
add wave -noupdate -radix hexadecimal /Mips/EXTDataIn
add wave -noupdate -radix hexadecimal /Mips/DMDataOut
add wave -noupdate -radix hexadecimal /Mips/DMAdd
add wave -noupdate -radix hexadecimal /Mips/ALUsrc
add wave -noupdate -radix hexadecimal /Mips/ALUop
add wave -noupdate -radix hexadecimal /Mips/ALUasrc
add wave -noupdate -radix hexadecimal /Mips/ALUDataOut
add wave -noupdate -radix hexadecimal /Mips/ALUDataIn2
add wave -noupdate -radix hexadecimal /Mips/ALUDataIn1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
