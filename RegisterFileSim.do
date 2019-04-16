vlib work
vlog -sv RegisterFile.sv RegisterFileTB.sv
vsim RegisterFileTB
do RegisterFileTbWave.do;
log -r /*
run -a
echo "DO NOT QUIT SIMULATION"