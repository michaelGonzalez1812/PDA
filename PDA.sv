/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					PDA
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0        
	
	Entradas:- Clk
				- reset
				- halt
				
	Restricciones:
				-
	
   Salidas: - Ejecucion de las instrucciones
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/

import stages_definition_pkg::*;


module PDA(input logic clk, reset, halt, // halt para detener la ejecucion
										  output logic [31:0] outFE, DecoVisu, ExeVisu, MemVisu, MemPixVisu, WBVisu); // es la instruccion entrante al pipeline
	
	deco_exe_cu_signals deco_exe_cu_sig_deco;
	deco_exe_interface deco_exe_inter_deco;
	deco_exe_cu_signals deco_exe_cu_sig_exe;
	deco_exe_interface deco_exe_inter_exe;

	exe_mem_cu_signals exe_mem_cu_sig_exe;
	exe_mem_interface exe_mem_inter_exe;
	exe_mem_cu_signals exe_mem_cu_sig_mem;
	exe_mem_interface exe_mem_inter_mem;

	mem_wb_cu_signals mem_wb_cu_sig_mem;
	mem_wb_interface mem_wb_inter_mem;
	mem_wb_cu_signals mem_wb_cu_sig_wb;
	mem_wb_interface mem_wb_inter_wb;

	int isntFetch, wbOutput, pcFetch;
	bit pcSrcExe;
	inst_header inst_head;
	conditional_flags cond_flags;

	ControlUnit UnidadControl (inst_head, //input
		deco_exe_cu_sig_deco); //output

	ConditionalUnit UniCondicion (clk, deco_exe_inter_exe.cond, //input
		cond_flags, deco_exe_cu_sig_exe.flagWrite, //input
		deco_exe_cu_sig_exe.memPixWrite, deco_exe_cu_sig_exe.branch, //input
		deco_exe_cu_sig_exe.memWrite, deco_exe_cu_sig_exe.regWrite, //input
		deco_exe_cu_sig_exe.pcSrc, //input
		exe_mem_cu_sig_exe.memPixWrite, exe_mem_cu_sig_exe.memWrite, //output
		exe_mem_cu_sig_exe.regWrite, exe_mem_cu_sig_exe.pcSrc, //output
		pcSrcExe); //output

	Fetch #(32) fetch_stage (clk, mem_wb_cu_sig_wb.pcSrc, //input
		pcSrcExe, wbOutput, exe_mem_inter_exe.aluResult, //input
		instFetch, pcFetch); //output
					
	DecodeStage #(32) decode_stage 
	   (inDE, PC, DataWrite,
					 Rd,
					 clk, RegWrite,
					 outDE[95:64], outDE[63:32], outDE[31:0], // Ra, Rb, ExtImm
					 outDE[99:96], // Rd
					 outDE[100], outDE[101], outDE[102], outDE[103], outDE[104], // MemPWrite, RegWriteOut, MemWrite, BranchInst, ALUSrc
					 outDE[105], outDE[106], outDE[107], outDE[108],  // FlagWrite, PAUOp, IOFlag, ResultSrc
					 outDE[112:109], // ALUControl
					 outDE[115:113], // CondFlag
					 outDE[117:116]); // MemToReg

	ExecuteStage #(32) execute_stage (inEXE[100], inEXE[101], inEXE[102], inEXE[103], inEXE[104], // MemPWrite, RegWrite, MemWrite, BranchInst, ALUSrc 
					  inEXE[105], inEXE[106], inEXE[107], inEXE[108], // FlagWrite, PAUOp, IOFlag, ResultSrc
					  clk,
					  inEXE[117:116], // MemToReg
					  inEXE[112:109], // ALUControl
					  inEXE[115:113], // CondFlag
					  inEXE[95:64], inEXE[63:32], inEXE[31:0], // Ra, Rb, ExtIm
					  inEXE[99:96], // Rd
					  outEXE);
					  /*
					  outEXE[70], outEXE[71], outEXE[72], outEXE[73], outEXE[74], // PCSrc, RegWriteOut, MemWriteOut, MemPWriteOut, IOFlagOut
					  outEXE[69:68], // MemToRegOut
					  outEXE[31:0], outEXE[63:32], // ALUResult, WriteData
					  outEXE[67:64]); // RdOut);
					  */
	MemoryStage #(32) memory_stage (clk,
							inMEM,
	/*
							inMEM[72], inMEM[73], inMEM[70], inMEM[71], inMEM[74], // MEMWrite, MemPWrite, PCSrc, RegWrite, IOFlag
							inMEM[69:68], // MemToReg
							inMEM[31:0], inMEM[63:32], // address, WriteData
							inMEM[67:64], // RdIn,
							*/
							outMEM[31:0], outMEM[63:32], outMEM[95:64], // ReadDataDataMem, ReadDataPixMem, ALUresultOut
							outMEM[99:96], // RdOut
							outMEM[102], outMEM[103], outMEM[104], // PCSrcOut, RegWriteOut, IOFlagOut
							outMEM[101:100]); // MemToRegOut 
							
	WriteBackStage #(32) writeback_stage (inWB[102], inWB[103], inWB[104], // PCSrc, RegWrite, IOFlag
						 inWB[101:100], // MemToReg
						 IOIn, inWB[31:0], inWB[63:32], inWB[95:64], // IOIn, ReadData, ReadDataP, ALUOut,
						 inWB[99:96], // Rd
						 DataWrite, 
						 Rd,
						 pcSrcWb, RegWrite);
						 
	Register #(32) if_de ({}, ~clk, enable, inDE);
	Register #(118) de_exe (outDE, ~clk, enable, inEXE);
	Register #(75) exe_mem (outEXE, ~clk, enable, inMEM);
	Register #(105) mem_wb ({mem_wb_cu_sig, mem_wb_inter} , ~clk, enable, inWB);
endmodule 