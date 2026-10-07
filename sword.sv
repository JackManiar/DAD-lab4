module sword(input logic sw, reset, clk,
				output logic v);
				
		typedef enum logic [1:0]{S0, S1} statetype;		
		statetype state, nextState;
		
		//state reg defined before 
		d_ff ff0(nextState[0], clk, state[0]);
		
		
		//next state logic
		always_comb
		begin
			if (reset)
				nextState = S0;
			else
				begin
					case (state)
						S0: 
							begin
								if (sw)
									nextState = S1;
								else
									nextState = S0;
							end
						S1:
							nextState = S1;
					endcase
				end
		end
		
		//output logic
		assign v = (state == S1);
endmodule
