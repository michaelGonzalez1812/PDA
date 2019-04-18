module RegisterFileTB();

	logic clk, WE3;
	bit   [3:0] A1, A2, A3;
	int   WD3, R15;
	int   RD1, RD2, R0, R1;

	RegisterFile DUT 
	   (clk, WE3, A1, A2, A3, WD3, R15, //input
		RD1, RD2, R0, R1);				//output
	
	initial begin
		clk = 1; 
		
		// lee valores iniciales de R0 R1
		WE3 = 0;
		WD3 = 0;
		A1 = 0;
		A2 = 1;
		A3 = 0;
		R15 = 0;
		
		// lee valores iniciales de R2 R3
		#3
		WE3 = 0;
		WD3 = 0;
		A1 = 2;
		A2 = 3;
		A3 = 0;
		
		// escribe 10 en R2 y lo lee a traves de A1
		#3
		WE3 = 1;
		WD3 = 100;
		A1 = 2;
		A2 = 0;
		A3 = 2;

		// escribe 256 en R0 y lo lee a traves de A1
		// Tambien debe verse reflejado en la salida R0
		#3
		WE3 = 1;
		WD3 = 1 << 8;
		A1 = 0;
		A2 = 0;
		A3 = 0;

		#3
		$stop;
	end

	always #1 clk = ~clk;
endmodule
