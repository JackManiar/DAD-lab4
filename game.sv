module game(input logic clk, n, s, e, w, reset,
				output logic s6, win, s5, d, s4, s3, sw, s2, s1, s0, v);
	
	//one instance of Room FSM module
		room room1(clk, n, s, e, w, v, reset,
					s6, win, s5, d, s4, s3, sw, s2, s1, s0);
		
	//one instance of Sword FSM module
		sword sword1(sw, reset, clk,
					v);

endmodule
