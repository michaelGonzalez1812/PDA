vlib work
vlog -sv PDA_tb.sv PDA.SV Decode.sv RegisterFile.sv Extend.sv ControlUnit.sv Register.sv Execute.sv
vlog -sv ALU.sv nBitsADD.sv ConditionalUnit.sv Fetch.sv InstructionMemory.sv
vlog -sv MemoryStage.sv Memory.sv PixelMemory.sv WriteBack.sv
vsim PDA_tb
do wave.do
log -r /*
run -a
echo "DO NOT QUIT SIMULATION"