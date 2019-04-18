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

import stages_definition_pkg::*;

module WriteBackStage #(parameter N=32)
	   (input mem_wb_interface mem_wb_inter_wb,
	    input bit [0:1] memToReg,
		output int outSelected);
	
	assign outSelected = (memToReg == 2'b00)? mem_wb_inter_wb.dataMemRead :
						 (memToReg == 2'b01)? mem_wb_inter_wb.aluResult :
						 (memToReg == 2'b10)? mem_wb_inter_wb.pixMemRead : mem_wb_inter_wb.trigResult;
endmodule   