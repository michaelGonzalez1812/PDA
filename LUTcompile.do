vlib work
vlog -sv senLUT.sv LUT.sv LUT_tb.sv
vsim LUT_tb
do lutwave.do
log -r /*
run -a
echo "DO NOT QUIT SIMULATION"