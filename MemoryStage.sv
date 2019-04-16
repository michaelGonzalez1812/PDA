/**
*********************************************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

						MemoryStage
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- 6 operando de entrada
				- Clock
				- Bandera de lectura/escritura de memoria de datos
				- Bandera de lectura/escritura de memoria de pixeles
			   - Direccion de lectura/escritura (ambas memorias)
				- Dato a escribir
				- Registro destino (debe salir el mismo dato)
				
	Restricciones:
				- Entradas son de N bits 
	
   Salidas: - Dato leido de la memoria de datos
				- Dato leido de la memoria de pixeles
				- Resultado proveniente de la execute stage
				- Registro destino
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
*********************************************************************
*/

import stages_definition_pkg::*;

module MemoryStage #(parameter N = 32) 
						  (input logic clk, 
						   exe_mem_interface in_signal,
						  /*MEMWrite, MemPWrite, PCSrc, RegWrite, IOFlag,
							input logic [1:0] MemToReg,
							input logic [N-1:0] address, WriteData,
							input logic [3:0] RdIn,*/
							output logic [N-1:0] ReadDataDataMem, ReadDataPixMem, ALUresultOut,
							output logic [3:0]  RdOut,
							output logic PCSrcOut, RegWriteOut, IOFlagOut,
							output logic [1:0] MemToRegOut);
	
	Memory data_memory(clk, in_signal.MemWrite, address, in_signal.WriteData, ReadDataDataMem);

	//assign ALUresultOut = address;
	assign ALUresultOut = in_signal.ALUResult;
	assign RdOut = in_signal.Rd;
	assign PCSrcOut = in_signal.PCSrc;
	assign RegWriteOut = in_signal.RegWrite;
	assign IOFlagOut = in_signal.IOFlag;
	assign MemToRegOut = in_signal.MemToReg;
endmodule