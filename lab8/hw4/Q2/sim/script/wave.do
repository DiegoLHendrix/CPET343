onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jk_flip_flop_tb/uut/clk
add wave -noupdate /jk_flip_flop_tb/uut/clear
add wave -noupdate /jk_flip_flop_tb/uut/preset
add wave -noupdate -color Orange /jk_flip_flop_tb/uut/j
add wave -noupdate -color Orange /jk_flip_flop_tb/uut/k
add wave -noupdate -color Cyan /jk_flip_flop_tb/uut/q
add wave -noupdate -color Yellow /jk_flip_flop_tb/uut/qn
add wave -noupdate /jk_flip_flop_tb/uut/temp
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
