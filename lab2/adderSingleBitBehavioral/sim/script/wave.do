onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Red /adderSingleBitBehavioral_tb/var_a
add wave -noupdate -color Blue /adderSingleBitBehavioral_tb/var_b
add wave -noupdate -color Magenta /adderSingleBitBehavioral_tb/cin
add wave -noupdate -color Gold /adderSingleBitBehavioral_tb/sum
add wave -noupdate /adderSingleBitBehavioral_tb/cout

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
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
WaveRestoreZoom {101 ns} {206 ns}
