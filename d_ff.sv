module d_ff(input logic d,clk,
				output logic q);
				
				always @(posedge clk) 
				begin
					q <= d;
				end
endmodule
