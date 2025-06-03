`timescale 1ns / 1ps

module top__tb();
    reg clk = 0;
    reg reset = 0;
    parameter SIZE_TMVP = 32;
    parameter N = 512;
    parameter REAL_N = 509;

    always @(*) begin
        #4
        clk <=  ~clk;
    end
    initial begin
        #50
        reset = 1;
		start = 1;
		#8
		start = 0; 
    end

    //Instance
    reg start;


    wire    [16:0]  m_axis_tdata;
    wire            m_axis_tvalid;

Top #(.N(N), .SIZE_TMVP(SIZE_TMVP), .DATA_WIDTH(4), .REAL_N(REAL_N)) DUT
        (.clk(clk), .reset(reset), 
        .start(start), 
        .m_axis_tdata(m_axis_tdata), .m_axis_tvalid(m_axis_tvalid));


    integer out_file;
    initial begin
        out_file = $fopen("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Main_Verification/TOP.dat", "w");
    end
    integer cnt_out;
    // Output
    always @(posedge clk) begin
        if (!reset) begin
            cnt_out <= 0;
        end
        else begin
            if (m_axis_tvalid) begin
                cnt_out <= cnt_out + 1;
                $fdisplay(out_file, m_axis_tdata);
            end
            if (cnt_out == REAL_N) begin
                $fclose(out_file);
                $finish();
            end 
        end
    end
endmodule
