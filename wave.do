onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label r0 -radix decimal {/ArquitecturaHybridARMIPS_tb/DUT/DE/BancoRegistro/rf[0]}
add wave -noupdate -label r1 -radix decimal {/ArquitecturaHybridARMIPS_tb/DUT/DE/BancoRegistro/rf[1]}
add wave -noupdate -label r2 -radix decimal {/ArquitecturaHybridARMIPS_tb/DUT/DE/BancoRegistro/rf[2]}
add wave -noupdate -label PC -radix decimal /ArquitecturaHybridARMIPS_tb/DUT/IF/PC/out
add wave -noupdate -label clk /ArquitecturaHybridARMIPS_tb/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 59
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {19 ps}
