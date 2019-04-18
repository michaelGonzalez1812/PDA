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
module LUT( input logic op_selector, clk,
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
    assign atmp4S = 32'b101101000 - angle; ; 

    SenLUT coseno1 (clk, atmp1C, tmp1C);
    SenLUT coseno2 (clk, atmp2C, tmp2C);
    SenLUT coseno3 (clk, atmp3C, tmp3C);
    SenLUT coseno4 (clk, atmp4C, tmp4C);

    SenLUT seno1 (clk, atmp1C, tmp1S);
    SenLUT seno2 (clk, atmp2C, tmp2S);
    SenLUT seno3 (clk, atmp3C, tmp3S);
    SenLUT seno4 (clk, atmp4C, tmp4S);

    always_ff @ (posedge clk) begin
        //coseno
        if (op_selector == 1) begin
            if(32'b0 <= angle && angle <= 32'b1011010) begin
                value <= tmp1C;
            end
            else if(32'b1011011 <= angle && angle <= 32'b10110100) begin
                value <= tmp2C;
            end
            else if(32'b10110101 <= angle && angle <= 32'b100001110) begin
                value <= tmp3C;
            end
            else if(32'b100001111 <= angle &&angle <= 32'b101101000) begin
                value <= tmp4C;
            end
        end
        //seno
        else begin
            if(32'b0 <= angle && angle <= 32'b1011010) begin
                value <= tmp1S;
            end
            else if(32'b1011011 <= angle && angle <= 32'b10110100) begin
                value <= tmp2S;
            end
             else if(32'b10110101 <= angle && angle <= 32'b100001110) begin
                value <= tmp3S;
            end
            else if(32'b100001111 <= angle &&angle <= 32'b101101000) begin
                value <= tmp4S;
            end
        end
    end
 
endmodule