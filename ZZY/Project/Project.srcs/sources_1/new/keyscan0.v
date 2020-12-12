`define OK 1'b1	//定义OK代表1
`define NO 1'b0	//定义NO代表0
`define NoKeyIsPressed 17	//定义NoKeyIsPressed代表17
 
//模块名及输入输出端口的定义
module keyscan0(clk,rst_n,keyscan,keyin,real_number);
 input clk,rst_n;//rst_n 1是enable， 0是disable
 
 input [3:0]keyin;
 output [3:0] keyscan;
 
 output [4:0] real_number;
 
 reg [3:0] state;
 reg [3:0] four_state; 
 reg [3:0] scancode,scan_state;
 reg [4:0] numberout,number_reg,number_reg1,number_reg2, real_number;   
 reg AnyKeyPressed;
 
 assign keyscan = scancode;
 
 always @(posedge clk)  //always块1
 if (!rst_n)
      begin
        scancode <=4'b0000;
        scan_state<= 4'b0000;
      end
 else
     if(AnyKeyPressed)
        case (scan_state)
			4'b0000: begin scancode<=4'b1110; scan_state<= 4'b0001; end
			4'b0001: begin  scancode <= {scancode[0],scancode[3:1]}; end      
        endcase
     else 
        begin
			scancode <=4'b0000;
			scan_state<= 4'b0000;
        end  

 always @(posedge clk)   //always块2  
 if( !(&keyin))
	begin
	 AnyKeyPressed <= `OK ;  
	 four_state <= 4'b0000;
	end
 else 
	if(AnyKeyPressed)
	   case(four_state)
		 4'b0000: begin  AnyKeyPressed <= `OK ;  four_state<=4'b0001; end
		 4'b0001: begin  AnyKeyPressed <= `OK ;  four_state<=4'b0010; end
		 4'b0010: begin  AnyKeyPressed <= `OK ;  four_state<=4'b0100; end
		 4'b0100: begin  AnyKeyPressed <= `OK ;  four_state<=4'b1000; end
		 4'b1000: begin  AnyKeyPressed <= `NO ;   end
		 default: AnyKeyPressed <= `NO ;
	   endcase
	else 
		 four_state <= 4'b0000;
          
always @(posedge clk) 	//always块3
  casex({scancode,keyin})
    8'b0111_1110: numberout <= 5'd1-1;
    8'b1011_1110: numberout <= 5'd5-1;  
    8'b1101_1110: numberout <= 5'd9-1;
    8'b1110_1110: numberout <= 5'd13-1; 
    
    8'b0111_1101: numberout <= 5'd2-1;
    8'b1011_1101: numberout <= 5'd6-1;  
    8'b1101_1101: numberout <= 5'd10-1;
    8'b1110_1101: numberout <= 5'd14-1; 
        
    8'b0111_1011: numberout <= 5'd3-1;
    8'b1011_1011: numberout <= 5'd7-1; 
    8'b1101_1011: numberout <= 5'd11-1;
    8'b1110_1011: numberout <= 5'd15-1; 
    
    8'b0111_0111: numberout <= 5'd4-1;
    8'b1011_0111: numberout <= 5'd8-1;  
    8'b1101_0111: numberout <= 5'd12-1;
    8'b1110_0111: numberout <= 5'd16-1;
    default: numberout <=`NoKeyIsPressed;
   endcase
   
always @(posedge clk) 	//always块4
begin
	if (!rst_n)
	begin
	  number_reg <= 0;
	end
	else
		if( numberout<=5'd15 && numberout>=5'd0)
			begin
				 number_reg <= numberout;  
			end
		else
			begin
				if(AnyKeyPressed == `NO)
					number_reg <= `NoKeyIsPressed;  
			end
		   
 end
         
always @(posedge clk)  //always块5
 if (!rst_n)
	state <= 4'b0000;
 else 
	case (state)
4'd0: begin   
			number_reg1 <= number_reg;
			state <=4'd1;
		end
4'd1: begin 
			if(number_reg == number_reg1)
				state <= 4'd2;
			else
				state <= 4'd0;
		end
4'd2: begin
			if (number_reg == number_reg1)                  
				state <= 4'd3;
			else
				state <= 4'd0;
		end                     
4'd3: begin
			if (number_reg == number_reg1)                
				state <= 4'd4;
			else
				state <= 4'd0;   
		end          
4'd4: begin   
			 if(number_reg == number_reg1)
				state <=4'd5;
			 else
				state <= 4'd0; 
		end
4'd5: begin 
			if(number_reg == number_reg1)
				state <= 4'd6;
			else
				state <= 4'd0;
		end
4'd6: begin
			if (number_reg == number_reg1)                  
				state <= 4'd7;
			else
				state <= 4'd0;
		end                     
4'd7: begin
			if (number_reg == number_reg1)                
				  state <= 4'd8;
			else
				  state <= 4'd0;   
		end          
4'd8: begin 
			if (number_reg == number_reg1)    
				  state <=4'd9;
			else
				  state <= 4'd0;  
		end
4'd9: begin 
			if(number_reg == number_reg1)
				  state <= 4'd10;
			else
				  state <= 4'd0;
		end
4'd10: begin
			if (number_reg == number_reg1)                  
				  state <= 4'd11;
			else
				 state <= 4'd0;
		end                     
4'd11: begin
			if (number_reg == number_reg1)                
				 state <= 4'd12;
			else
				 state <= 4'd0;   
		end          
4'd12: begin 
			if(number_reg == number_reg1)
			  state <= 4'd13;
			else
			  state <= 4'd0;
		end
4'd13: begin
			if (number_reg == number_reg1)                  
				  state <= 4'd14;
			else
				 state <= 4'd0;
		end                     
4'd14: begin
			if (number_reg == number_reg1)                
			 state <= 4'd15;
			else
			 state <= 4'd0;   
		end                 
4'd15: begin
			if (number_reg == number_reg1 ) 
				begin                 
					state <= 4'd0;
					real_number <=number_reg; 
				end
			else
						 state <= 4'b0000;   
		end                        
  default:   state <= 4'b0000;   
  endcase   
endmodule