onerror {resume}
radix define States {
    "8'b000?????" "Play" -color "green",
    "8'b001?????" "Play Repeat" -color "purple",
    "8'b01??????" "Pause" -color "orange",
    "8'b10??????" "Seek" -color "blue",
    "8'b11??????" "Stop" -color "red",
    -default hexadecimal
    -defaultcolor white
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/clk
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/reset
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/execute_btn
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/sync
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/execute_sync
add wave -noupdate -radix hexadecimal -radixshowbase 1 /dj_roomba_3000_tb/dj_roomba/led
add wave -noupdate -radix hexadecimal -radixshowbase 1 /dj_roomba_3000_tb/dj_roomba/audio_out
add wave -noupdate -radix hexadecimal -radixshowbase 1 /dj_roomba_3000_tb/dj_roomba/data_address
add wave -noupdate -radix States -childformat {{/dj_roomba_3000_tb/dj_roomba/current_instructions(7) -radix States} {/dj_roomba_3000_tb/dj_roomba/current_instructions(6) -radix States} {/dj_roomba_3000_tb/dj_roomba/current_instructions(5) -radix States} {/dj_roomba_3000_tb/dj_roomba/current_instructions(4) -radix States} {/dj_roomba_3000_tb/dj_roomba/current_instructions(3) -radix States} {/dj_roomba_3000_tb/dj_roomba/current_instructions(2) -radix States} {/dj_roomba_3000_tb/dj_roomba/current_instructions(1) -radix States} {/dj_roomba_3000_tb/dj_roomba/current_instructions(0) -radix States}} -subitemconfig {/dj_roomba_3000_tb/dj_roomba/current_instructions(7) {-height 15 -radix States} /dj_roomba_3000_tb/dj_roomba/current_instructions(6) {-height 15 -radix States} /dj_roomba_3000_tb/dj_roomba/current_instructions(5) {-height 15 -radix States} /dj_roomba_3000_tb/dj_roomba/current_instructions(4) {-height 15 -radix States} /dj_roomba_3000_tb/dj_roomba/current_instructions(3) {-height 15 -radix States} /dj_roomba_3000_tb/dj_roomba/current_instructions(2) {-height 15 -radix States} /dj_roomba_3000_tb/dj_roomba/current_instructions(1) {-height 15 -radix States} /dj_roomba_3000_tb/dj_roomba/current_instructions(0) {-height 15 -radix States}} /dj_roomba_3000_tb/dj_roomba/current_instructions
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/CurrentState
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/error
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/clk
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/reset
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/execute_btn
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/sync
add wave -noupdate -radix hexadecimal -radixshowbase 1 /dj_roomba_3000_tb/dj_roomba/led
add wave -noupdate -radix hexadecimal -radixshowbase 1 /dj_roomba_3000_tb/dj_roomba/audio_out
add wave -noupdate -radix hexadecimal -radixshowbase 1 /dj_roomba_3000_tb/dj_roomba/data_address
add wave -noupdate -radix hexadecimal -radixshowbase 1 /dj_roomba_3000_tb/dj_roomba/instruction
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/CurrentState
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/NextState
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/play_complete
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/play_once
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/play_repeat
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/pause
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/seek
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/stop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {585017 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 128
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {2100 ns}
