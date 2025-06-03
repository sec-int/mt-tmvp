`timescale 1ns / 1ps
module multiplier__tb();
    reg clk = 0;
    reg reset = 0;
    parameter N = 16;
    parameter DATA_WIDTH = 8;
    always @(*) begin
        #4
        clk <=  ~clk;
    end
    initial begin
        #50
        reset = 1; 
    end

    // loading files
    reg     [DATA_WIDTH - 1:0]       row     [N-1:0];
    reg     [DATA_WIDTH - 1:0]       col     [N-1:0];
    reg     [DATA_WIDTH - 1:0]       vec     [N-1:0];

    initial begin
        $readmemh("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Multiplier_Verification/Row.dat", row);
        $readmemh("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Multiplier_Verification/Col.dat", col);
        $readmemh("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Multiplier_Verification/Vec.dat", vec);
    end

    //Instance
    reg     [DATA_WIDTH-1:0]    s_axis_tdata_row;
    reg                         s_axis_tvalid;
    reg     [DATA_WIDTH-1:0]    s_axis_tdata_vec;
    wire    [DATA_WIDTH-1:0]    m_axis_tdata;
    wire                        m_axis_tvalid;

    MatrixVectorMultiplier #(.N(N), .DATA_WIDTH(DATA_WIDTH)) DUT
        (.clk(clk), .reset(reset), 
        .s_axis_tdata_vec(s_axis_tdata_vec), 
        .s_axis_tdata_row(s_axis_tdata_row), .s_axis_tvalid(s_axis_tvalid),
        .m_axis_tdata(m_axis_tdata), .m_axis_tvalid(m_axis_tvalid)
    );

    // Input
    integer cnt = 0;
    always @(posedge clk) begin
        if (!reset) begin
            s_axis_tdata_row <= 0;
            s_axis_tdata_vec <= 0;
            s_axis_tvalid <= 0;
            cnt <=  0;
        end
        else begin
            if (cnt < 40) begin
                cnt <= cnt + 1;    
            end
            if (cnt < N) begin
                s_axis_tdata_row  <= row[N-1 - cnt];
                s_axis_tvalid <= 1;
                s_axis_tdata_vec  <= vec[N-1 - cnt];
            end
            else if (cnt < 2*N-1) begin
                s_axis_tdata_row  <= col[cnt - N + 1];
                s_axis_tvalid <= 1;
                s_axis_tdata_vec  <= 0;
            end
            else begin
                s_axis_tdata_row  <= 0;
                s_axis_tvalid       <= 0;
                s_axis_tdata_vec  <= 0;
            end
        end
    end


    integer out_file;
    initial begin
        out_file = $fopen("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Multiplier_Verification/Out.dat", "w");
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
            if (cnt_out == N) begin
                $fclose(out_file);
                $finish();
            end 
        end
    end
endmodule
