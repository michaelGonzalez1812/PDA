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
		input  logic clk, enable,
		output logic [N-1:0] out={N{1'b0}});
		
	always_ff @ (posedge clk) begin
		if (enable) out<=in;
		else out<=out;
	end	
endmodule 