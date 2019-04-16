onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RegisterFileTB/clk
add wave -noupdate /RegisterFileTB/WE3
add wave -noupdate /RegisterFileTB/A1
add wave -noupdate /RegisterFileTB/A2
add wave -noupdate /RegisterFileTB/A3
add wave -noupdate /RegisterFileTB/WD3
add wave -noupdate /RegisterFileTB/R15
add wave -noupdate /RegisterFileTB/RD1
add wave -noupdate /RegisterFileTB/RD2
add wave -noupdate /RegisterFileTB/R0
add wave -noupdate /RegisterFileTB/R1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 209
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {15 ps}
