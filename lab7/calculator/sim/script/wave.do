onerror {resume}
radix define States {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    "7'b0001000" "A" -color "red",
    "7'b0000011" "b" -color "red",
    "7'b1000110" "C" -color "red",
    "7'b0100001" "d" -color "red",
    "7'b0000110" "E" -color "red",
    "7'b0001110" "F" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /seven_seg_tb/uut/clk
add wave -noupdate /seven_seg_tb/uut/reset
add wave -noupdate /seven_seg_tb/uut/led
add wave -noupdate -radix unsigned /seven_seg_tb/uut/switch
add wave -noupdate -radix States /seven_seg_tb/uut/bcd_0
add wave -noupdate -radix States /seven_seg_tb/uut/bcd_1
add wave -noupdate -radix States /seven_seg_tb/uut/bcd_2
add wave -noupdate /seven_seg_tb/uut/op_sync
add wave -noupdate /seven_seg_tb/mr
add wave -noupdate /seven_seg_tb/uut/mr_sync
add wave -noupdate /seven_seg_tb/ms
add wave -noupdate /seven_seg_tb/uut/ms_sync
add wave -noupdate /seven_seg_tb/execute
add wave -noupdate /seven_seg_tb/uut/execute_sync
add wave -noupdate /seven_seg_tb/uut/we
add wave -noupdate -radix unsigned /seven_seg_tb/uut/a
add wave -noupdate -radix unsigned /seven_seg_tb/uut/b
add wave -noupdate -radix unsigned /seven_seg_tb/uut/result
add wave -noupdate /seven_seg_tb/uut/addr
add wave -noupdate /seven_seg_tb/uut/top_mem/we
add wave -noupdate /seven_seg_tb/uut/top_mem/addr
add wave -noupdate -radix unsigned /seven_seg_tb/uut/top_mem/din
add wave -noupdate -radix unsigned /seven_seg_tb/uut/top_mem/dout
add wave -noupdate -radix unsigned /seven_seg_tb/uut/top_mem/RAM
add wave -noupdate -radix unsigned /seven_seg_tb/uut/output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {207902 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {1050 ns}
