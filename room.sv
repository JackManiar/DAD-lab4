module room(input logic clk, n, s, e, w, v, reset,
				output logic s6, win, s5, d, s4, s3, sw, s2, s1, s0);
				
	typedef enum logic[6:0]{
					S0=7'b0000001, 
					S1=7'b0000010, 
					S2=7'b0000100, 
					S3=7'b0001000, 
					S4=7'b0010000, 
					S5=7'b0100000, 
					S6=7'b1000000
					} statetype;
					
		statetype state, nextState;
		
		//state reg defined before 
		d_ff ff0(nextState[0], clk, state[0]);
		d_ff ff1(nextState[1], clk, state[1]);
		d_ff ff2(nextState[2], clk, state[2]);
		d_ff ff3(nextState[3], clk, state[3]);
		d_ff ff4(nextState[4], clk, state[4]);
		d_ff ff5(nextState[5], clk, state[5]);
		d_ff ff6(nextState[6], clk, state[6]);
		
		
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
								if (e & ~(n | s | w)) //don't need the ~reset bc handled it with the if statement before case
									nextState = S1;
								else
									nextState = S0;
							end
						S1: 
							begin
								if (w & ~(n | e | s))
									nextState = S0;
								else if (s & ~(w | n | e))
									nextState = S2;
								else
									nextState = S1;
							end
						S2:
							begin
								if (w & ~ (n | s | e))
									nextState = S3;
								else if(n & ~(e | s | w))
									nextState = S1;
								else if(s & e & ~(n | w))
									nextState = S4;
								else	
									nextState = S2;
							end
						S3:
							begin
								if (e & ~(n | s | w))
									nextState = S2;
								else	
									nextState = S3;
							end
						S4:
							begin
								if (v)
									nextState = S6;
								else
									nextState = S5;
							end
						S5:
							nextState = S5;
						S6:
							nextState = S6;
						default: nextState = S0;
					endcase
				end
			end
					
			//output logic
			assign s6 = (state == S6);
			assign win = (state == S6);
			assign s5 = (state == S5);
			assign d = (state == S5);
			assign s4 = (state == S4);
			assign s3 = (state == S3);
			assign sw = (state == S3);
			assign s2 = (state == S2);
			assign s1 = (state == S1);
			assign s0 = (state == S0);
			
endmodule
