module TOP(input logic clk, reset, halt, // halt para detener la ejecucion
		output inst_header inst_head,
		output logic [6:0] HEX0,
		output logic [6:0] HEX1,
		output logic [6:0] HEX2,
		output logic [6:0] HEX3,
		output logic [6:0] HEX4,
		output logic [6:0] HEX5,
		output logic [6:0] HEX6,
		output logic [6:0] HEX7);
	
	logic [31:0] pixelMemDisplay;

	Display7Seg display0 (pixelMemDisplay[3:0],   HEX0);
	Display7Seg display0 (pixelMemDisplay[7:4],   HEX1);
	Display7Seg display0 (pixelMemDisplay[11:8],  HEX2);
	Display7Seg display0 (pixelMemDisplay[15:12], HEX3);
	Display7Seg display0 (pixelMemDisplay[19:16], HEX4);
	Display7Seg display0 (pixelMemDisplay[23:20], HEX5);
	Display7Seg display0 (pixelMemDisplay[27:24], HEX6);
	Display7Seg display0 (pixelMemDisplay[31:28], HEX7);
	
	PDA cpu (clk, reset, halt, inst_head, pixelMemDisplay);
endmodule 