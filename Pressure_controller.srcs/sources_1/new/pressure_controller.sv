module pressure_controller(
    input logic clk, rst,
    input logic start_stb_i,
    input logic [3:0] pressure_i,
    input logic testmode,
    output logic captured_o, 
    output logic stable_flag_o,
    output logic test_flag_o
    );
    
localparam [2:0] s0 = 0; // idlle
localparam [2:0] s1 = 1; // wait
localparam [2:0] s2 = 2; // capture_pressure
localparam [2:0] s3 = 3; // stable
localparam [2:0] s4 = 4; // testmode
localparam [2:0] s5 = 5; // pressure lin
localparam [2:0] s6 = 6; // fault

logic [2:0] state, next_state;
logic [2:0] counter_s;
logic [2:0] pressure_s;
logic circuit_stable_s;
logic correct_stb_s, error_stb_s;


always_ff @(posedge clk) begin
    if (~rst) begin
        state <= s0;
    end
    else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    case (state)
        s0: begin
           if (rst) next_state = s1; 
        end
        s1: begin
            if (start_stb_i) next_state = s2;
            if (~rst) next_state = s0;
        end
        s2: begin
            if (circuit_stable_s == 1)  next_state = s3;
        end
        s3: begin
            if (testmode == 1) next_state = s4;
        end
        s4: begin
            if (start_stb_i == 1) next_state = s5;
        end
        s5: begin
            if (error_stb_s == 1) next_state = s6;
            if (correct_stb_s == 1) next_state = s3;
        end
        s6: begin
            if (~rst) next_state = s0;
        end
        default: next_state = s0;
    endcase
end    

always_ff @(posedge clk) begin
    case (state)
        s0: begin
            captured_o <= 0;
            stable_flag_o <= 0;
            test_flag_o <= 0;
        end
        s1: begin
            captured_o <= 0;
            stable_flag_o <= 0;
            test_flag_o <= 0;
        end
        s2: begin
            if (~rst) begin
                counter_s <= 0;
                captured_o <= 0;
            end
            else begin
                if (counter_s == 7) begin
                    circuit_stable_s <= 1;
                    captured_o <= 1;            
                    end
                else begin
                    counter_s <= counter_s + 1;
                end
            end
        end
        s3: begin
            stable_flag_o <= 1;
            if (start_stb_i == 1 || testmode == 1) begin
                stable_flag_o <= 0;    
            end
        end
        s4: begin
            test_flag_o <= 1;
            captured_o <= 0;
            stable_flag_o <= 0;
            if (start_stb_i == 1) begin
                test_flag_o <= 1;
                captured_o <= 0;
                stable_flag_o <= 0;
            end
        end
        s5: begin 
            if (pressure_i == pressure_s) begin
                correct_stb_s <= 1;
            end else begin
                error_stb_s <= 1;
            end
            test_flag_o <= 1;
        end
        s6: begin
            test_flag_o <= 1;
        end
        default: begin
            captured_o <= 0;
            stable_flag_o <= 0;
            test_flag_o <= 0;
        end
    endcase
end

    
endmodule
