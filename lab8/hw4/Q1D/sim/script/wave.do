onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /d_flip_flop_tb/uut/clk
add wave -noupdate /d_flip_flop_tb/uut/reset
add wave -noupdate /d_flip_flop_tb/uut/preset
add wave -noupdate -color Orange /d_flip_flop_tb/uut/data
add wave -noupdate -color Cyan /d_flip_flop_tb/uut/que
add wave -noupdate -color Yellow /d_flip_flop_tb/uut/not_que
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
WaveRestoreZoom {0 ps} {630 ns}
