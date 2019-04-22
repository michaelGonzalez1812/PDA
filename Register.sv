/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Registro Basico
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- Valor de N bits
				- Reloj
				- Parametro N bits
				
	Restricciones:
				- Entrada debe ser de N bits
	
   Salidas: - Cuando pasa al semiciclo positivo
				la entrada pasa a la salida

            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/
module Register #(parameter N=32)
	   (input  logic [N-1:0] in,
		input  logic clk, enable, reset,
		output logic [N-1:0] out={N{1'b0}});
		
	always_ff @ (posedge clk) begin
		if (reset)
			out <= {N{1'b0}};	
		else
			if (enable) out<=in;
			else out<=out;
	end	
/*
	always_ff @ (posedge reset) begin
		out <= {N{1'b0}};
	end*/
endmodule 