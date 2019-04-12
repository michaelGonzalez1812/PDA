vlib work
vlog -sv ArquitecturaHybridARMIPS_tb.sv ArquitecturaHybridARMIPS.SV Decode.sv RegisterFile.sv Extend.sv ControlUnit.sv Register.sv Execute.sv
vlog -sv ALU.sv nBitsADD.sv PAU.sv AverageUnit.sv UmbralUnit.sv ConditionalUnit.sv Fetch.sv InstructionMemory.sv
vlog -sv MemoryStage.sv Memory.sv PixelMemory.sv WriteBack.sv Display_7segments_controller.sv
vsim ArquitecturaHybridARMIPS_tb
do wave.do
do mem.do
log -r /*
run -a
echo "DO NOT QUIT SIMULATION"