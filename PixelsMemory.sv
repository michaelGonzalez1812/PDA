module PixelsMemory #(parameter N = 32) (input  logic clk, wr,
        input  int addrX, addrY, pixelIn,
        output int pixelOut);
	
	int mem[320][240];
	initial begin
		//$readmemb("pix.mem", mem[0]); 	
	end
	
	always_ff @(negedge clk) begin
		if (wr == 1)
			mem[addrX][addrY] <= pixelIn;	
	end
	
	always_ff @(posedge clk) begin
		if (wr == 0)
			pixelOut <= mem[addrX][addrY];
	end
endmodule