/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Etapa Execute
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- Señales de control
				- Operandos Ra y Rb
				- Direccion de Rd
				
	Restricciones:
				- Verificar las señales de control
	
   Salidas: - Señales de control
				- Resultado de la exe
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/

import stages_definition_pkg::*;

module ExecuteStage #(parameter N=32)
					(input logic MemPWrite, RegWrite, MemWrite, BranchInst, ALUSrc, FlagWrite, PAUOp, IOFlag, ResultSrc, clk,  /***Eliminar PAUOp ResultSrc*/
					 input logic [1:0] MemToReg,
					 input logic [3:0] ALUControl,
					 input logic [2:0] CondFlag,
					 input logic [31:0] Ra, Rb, ExtIm,
					 input logic [3:0] Rd,
					 output exe_mem_interface out_signal);
					 /*output logic PCSrc, RegWriteOut, MemWriteOut, MemPWriteOut, IOFlagOut,
					 output logic [1:0] MemToRegOut,
					 output logic [N-1:0] ALUResult, WriteData, 
					 output logic [3:0] RdOut);*/
	logic z, v, n, enable2, condi;
	logic [31:0] ALUOut, RbMux;
	assign out_signal.MemPWrite = MemPWrite;
	//assign RegWriteOut = RegWrite;
	assign out_signal.MemToReg = MemToReg;
	assign out_signal.MemWrite = MemWrite;
	assign out_signal.IOFlag = IOFlag;
	assign out_signal.Rd = Rd;
	assign out_signal.WriteData = Rb;
	assign enable2 = BranchInst | RegWrite; //new
	assign out_signal.RegWrite = condi & RegWrite; //new
	assign out_signal.PCSrc = condi & BranchInst; //new
	ConditionalUnit UniCondicion (z, v, n, FlagWrite, enable2, clk, CondFlag, condi);
	ALU #(32) ALUnit (Ra, RbMux, ALUControl, z, n, v, out_signal.ALUResult);
	assign RbMux = (ALUSrc) ? ExtIm : Rb;
endmodule 