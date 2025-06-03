`timescale 1ns / 1ps
module main__tb();
    reg clk = 0;
    reg reset = 0;

    parameter N = 864;
    parameter DATA_WIDTH = 4;
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

    // loading files
    reg     [3:0]       row     [N-1:0];
    reg     [3:0]       col     [N-1:0];
    reg     [3:0]       vec     [N-1:0];

    initial begin
        $readmemh("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Main_Verification/Row.dat", row);
        $readmemh("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Main_Verification/Col.dat", col);
        $readmemh("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Main_Verification/Vec.dat", vec);
    end

    //Instance
    reg start;
    wire ready;

    reg     [DATA_WIDTH-1:0]    data_row_data_1;
    reg     [DATA_WIDTH-1:0]    data_row_data_2;
    reg                         data_row_valid;
    reg     [DATA_WIDTH-1:0]    data_vec_data_1;
    reg     [DATA_WIDTH-1:0]    data_vec_data_2;
    reg                         data_vec_valid;
    wire    [$clog2(N)-1:0]     address_1;
    wire                        address_1_isRow;
    wire    [$clog2(N)-1:0]     address_2;
    wire                        address_2_isRow;
    wire                        address_valid;
    wire    [$clog2(N)-1:0]     address_vec_1;
    wire    [$clog2(N)-1:0]     address_vec_2;
    wire                        address_vec_valid;

    wire    [2*DATA_WIDTH-1 + $clog2(N):0]  m_axis_tdata;
    wire                                    m_axis_tvalid;

MainMultiplier #(.N(N), .SIZE_TMVP(24), .DATA_WIDTH(DATA_WIDTH)) DUT
        (.clk(clk), .reset(reset), 
        .start(start), 
        .address_1(address_1), .address_1_isRow(address_1_isRow),
        .address_2(address_2), .address_2_isRow(address_2_isRow),
        .address_valid(address_valid),
        .address_vec_1(address_vec_1), .address_vec_2(address_vec_2), .address_vec_valid(address_vec_valid),
		.data_row_data_1(data_row_data_1), .data_row_data_2(data_row_data_2), .data_row_valid(data_row_valid),
		.data_vec_data_1(data_vec_data_1), .data_vec_data_2(data_vec_data_2), .data_vec_valid(data_vec_valid),
        .m_axis_tdata(m_axis_tdata), .m_axis_tvalid(m_axis_tvalid));

    // Input
    integer cnt = 0;
    always @(posedge clk) begin
        if (!reset) begin
            data_row_data_1 <= 0;
            data_row_data_2 <= 0;
            data_row_valid  <= 0;
            data_vec_data_1 <= 0;
            data_vec_data_2 <= 0;
            data_vec_valid  <= 0;
        end
        else begin  
			// row
            data_row_valid      <=  address_valid;
            if (address_1_isRow) begin
                data_row_data_1 <= 	row[address_1];
            end
            else begin
                data_row_data_1 <= 	col[address_1];
            end
            if (address_2_isRow) begin
                data_row_data_2 <= 	row[address_2];
            end
            else begin
                data_row_data_2 <= 	col[address_2];
            end
			// vec
            data_vec_valid      <=  address_vec_valid;
			data_vec_data_1		<=	vec[address_vec_1];
			data_vec_data_2		<=	vec[address_vec_2];
        end
    end


    integer out_file;
    initial begin
        out_file = $fopen("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Main_Verification/Out.dat", "w");
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
