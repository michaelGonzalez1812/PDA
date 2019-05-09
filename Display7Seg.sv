
parameter CERO =    7'b1000000;
parameter UNO =     7'b1111001;
parameter DOS =     7'b0100100;
parameter TRES =    7'b0110000;
parameter CUATRO =  7'b0011001;
parameter CINCO =   7'b0010010;
parameter SEIS =    7'b0000010;
parameter SIETE =    7'b1111000;
parameter OCHO =    7'b0000000;
parameter NUEVE =   7'b0011000;
parameter DIEZ =    7'b0001000;
parameter ONCE =    7'b0000000;
parameter DOCE =    7'b1000110;
parameter TRECE =   7'b1000000;
parameter CATORCE = 7'b0000110;
parameter QUINCE =  7'b0001110;

module Display7Seg(input logic [0:3] num,
				   output logic [6:0] display); // segmentos del display
	
    assign display = (num == 4'b0000) ? CERO    :
                     (num == 4'b0001) ? UNO     :
                     (num == 4'b0010) ? DOS     :
                     (num == 4'b0011) ? TRES    :
                     (num == 4'b0100) ? CUATRO  :
                     (num == 4'b0101) ? CINCO   :
                     (num == 4'b0110) ? SEIS    :
                     (num == 4'b0111) ? SIETE   :
                     (num == 4'b1000) ? OCHO    :
                     (num == 4'b1001) ? NUEVE   :
                     (num == 4'b1010) ? DIEZ    :
                     (num == 4'b1011) ? ONCE    :
                     (num == 4'b1100) ? DOCE    :
                     (num == 4'b1101) ? TRECE   :
                     (num == 4'b1110) ? CATORCE : QUINCE;
endmodule 