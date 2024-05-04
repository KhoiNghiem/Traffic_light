module countryroad_fsm(
    input clk,
    input rst_n,
    input car, // cho la switch 
    input [5:0] green_time,
    input [5:0] yellow_time,
    input enable_n,

    output reg enable_h,
    output reg start_n,
    output[2:0] light_r
);

reg[2:0] CurrentState, NextState;

parameter [2:0] 
    green_r = 3'b100,
    yellow_r = 3'b010,
    red_r = 3'b001;

assign light_r = CurrentState;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    CurrentState <= red_r;
    else 
    CurrentState <= NextState;
end

always @(NextState, CurrentState,enable_n, green_time, yellow_time,car )
 begin
    NextState = CurrentState;
    start_n =0;
    enable_h =0;
    case(CurrentState)
        green_r: if(car==0 ||green_time == 1) begin
            NextState = yellow_r;
            start_n =1; // bat che do dem lai de dem thoi gian t cho den vang
        end
        yellow_r: if(yellow_time == 1) begin
            NextState = red_r;
            enable_h=1; 
        end
        red_r: if(enable_n) begin
            NextState = green_r;
            start_n =1; // bat che do dem thoi gian cua den xanh
        end 
    endcase
end


endmodule