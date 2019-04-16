/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Etapa WriteBack
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0        
	
	Entradas:- Señales de control
				- Entrada IO
				- Dato a guardar 
				- Direccion de Rd
				
	Restricciones:
				- Verificar las señales de control
	
   Salidas: - Señales de control
				- Resultado de la exe
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/
module WriteBackStage #(parameter N=32)
						(input logic PCSrc, RegWrite, IOFlag,
						 input logic [1:0] MemToReg,
						 input logic [N-1:0] IOIn, ReadData, ReadDataP, ALUOut, 
						 input logic [3:0] Rd,
						 output logic [N-1:0] OutData, 
						 output logic [3:0] RdOut,
						 output logic PCSrcOut, RegWriteOut);
	logic [N-1:0] Result;
	assign Result = (MemToReg == 2'b0) ? ReadData : (MemToReg == 2'b1) ? ALUOut : (MemToReg == 2'b10) ? ReadDataP : 32'b0;
	assign OutData = (IOFlag) ? IOIn : Result;
	assign PCSrcOut = PCSrc;
	assign RegWriteOut = RegWrite;
	assign RdOut = Rd;
endmodule   