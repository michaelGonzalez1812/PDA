onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PDA_tb/clk
add wave -noupdate -radix decimal {/PDA_tb/DUT/decode_stage/BancoRegistro/rf[3]}
add wave -noupdate -radix decimal {/PDA_tb/DUT/decode_stage/BancoRegistro/rf[4]}
add wave -noupdate /PDA_tb/DUT/cu/inst_head
add wave -noupdate -radix decimal /PDA_tb/DUT/execute_stage/alu/a
add wave -noupdate -radix decimal /PDA_tb/DUT/execute_stage/alu/b
add wave -noupdate -radix decimal /PDA_tb/DUT/execute_stage/alu/result
add wave -noupdate -radix decimal /PDA_tb/DUT/memory_stage/exe_mem_inter_mem.aluResult
add wave -noupdate -radix decimal /PDA_tb/DUT/decode_stage/Extension/imm
add wave -noupdate /PDA_tb/DUT/decode_stage/Extension/imm
add wave -noupdate /PDA_tb/DUT/decode_stage/Extension/ImmSrc
add wave -noupdate /PDA_tb/DUT/cu/immSrc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 439
configure wave -valuecolwidth 203
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
WaveRestoreZoom {17 ps} {37 ps}
