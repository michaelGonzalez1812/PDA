vlib work
vlog -sv ALU.sv ALU_tb.sv
vsim ALU_tb
do aluwave.do
log -r /*
run -a
echo "DO NOT QUIT SIMULATION"