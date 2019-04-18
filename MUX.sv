module MUX
			#(parameter width = 3)
			 (input logic [width-1:0] d0, d1, d2, d3, d4, d5, d6, d7, d8,
			  input logic [3:0] s,
			  output logic [width-1:0] result);
			  
	assign result = s[3] ? (d5) : (s[2] ? (s[1] ? (s[0] ? (d4) : (d7) ) : (s[0] ? (d2) : (d6) )) : (s[1] ? (s[0] ? (d3) : (d0) ) : (s[0] ? (d1) : (d8) ) ));
	
endmodule
