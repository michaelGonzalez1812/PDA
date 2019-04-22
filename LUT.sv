/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				Look Up Table Coseno y Seno
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas: - Selector de operación
                    0 Seno
                    1 Coseno
              - Ángulo
				
	Restricciones:
				- Selector solo 1 o 0
                - Ángulo [0,360]

   Salidas: - Coseno o seno del ángulo dado

            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/
module LUT( input logic op_selector,
            input logic [31:0] angle,
            output logic [31:0] value);  
            
    //valores temporales para coseno      
    logic [31:0] tmp1C;
    logic [31:0] tmp2C;
    logic [31:0] tmp3C; 
    logic [31:0] tmp4C;

    //variables temporales para seno
    logic [31:0] tmp1S;
    logic [31:0] tmp2S;
    logic [31:0] tmp3S; 
    logic [31:0] tmp4S;

    //angulos calculados para coseno
    logic [31:0] atmp1C; 
    logic [31:0] atmp2C; 
    logic [31:0] atmp3C; 
    logic [31:0] atmp4C; 

    //angulos calculados para seno
    logic [31:0] atmp1S; 
    logic [31:0] atmp2S; 
    logic [31:0] atmp3S; 
    logic [31:0] atmp4S; 

    //ángulos equivalentes para coseno
    assign atmp1C = 32'b1011010 - angle; 
    assign atmp2C = 32'b1011010 - angle; 
    assign atmp3C = 32'b1111000 - angle; 
    assign atmp4C = -(32'b100001110 - angle); 

    //ángulos equivalentes para seno
    assign atmp1S = angle; 
    assign atmp2S = 32'b10110100 - angle; 
    assign atmp3S = -(32'b10110100 - angle); 
    assign atmp4S = 32'b101101000 - angle;

    SenLUT coseno1 (atmp1C, tmp1C);
    SenLUT coseno2 (atmp2C, tmp2C);
    SenLUT coseno3 (atmp3C, tmp3C);
    SenLUT coseno4 (atmp4C, tmp4C);

    SenLUT seno1 (atmp1S, tmp1S);
    SenLUT seno2 (atmp2S, tmp2S);
    SenLUT seno3 (atmp3S, tmp3S);
    SenLUT seno4 (atmp4S, tmp4S);

    assign value = op_selector ? ((32'b0 <= angle && angle <= 32'b1011010) ? (tmp1C) 
                : ((32'b1011011 <= angle && angle <= 32'b10110100) ? (tmp2C) 
                : ((32'b10110101 <= angle && angle <= 32'b100001110) ? (tmp3C) 
                : ((32'b100001111 <= angle &&angle <= 32'b101101000) ? (tmp4C) 
                : (31'b0))))) 
                : ((32'b0 <= angle && angle <= 32'b1011010) ? (tmp1S) 
                : ((32'b1011011 <= angle && angle <= 32'b10110100) ? (tmp2S) 
                : ((32'b10110101 <= angle && angle <= 32'b100001110) ? (tmp3S) 
                : ((32'b100001111 <= angle &&angle <= 32'b101101000) ? (tmp4S) 
                : (31'b0)))));

 
endmodule