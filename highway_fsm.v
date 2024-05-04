module highway_fsm(
    input clk, 
    input rst_n,
    input car,
    input [5:0] green_time,
    input [5:0] yellow_time,
    input enable_h,

    output reg enable_n,
    output reg start_h,
    output[2:0] light_h
);

reg[2:0] CurrentState,NextState;


parameter [2:0] 
    green_h = 3'b100,
    yellow_h = 3'b010,
    red_h = 3'b001;

assign light_h = CurrentState;

always @(posedge clk or negedge rst_n)
    
begin
    if(!rst_n)
    CurrentState <= green_h;
    else 
    CurrentState <= NextState;
end

always @(NextState, CurrentState,enable_h, green_time, yellow_time,car )
 begin
    NextState = CurrentState;
    start_h =0;
    enable_n =0;
    case(CurrentState)
        green_h: if(car == 1 && green_time == 1) begin
            NextState = yellow_h;
            start_h =1;
        end
        yellow_h: if(yellow_time == 1) begin
            NextState = red_h;
            enable_n=1;
        end
        red_h: if(enable_h) begin
            NextState = green_h;
            start_h =1;
        end 
    endcase
end

endmodule