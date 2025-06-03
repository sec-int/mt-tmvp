function c = Main_Multiplier(Col, Row, Vec, Size_TMPV)
    L = length(Vec);
    n = L/Size_TMPV;
    c = zeros(L, 1);
    for row_idx=1:n
        result_temp = zeros(Size_TMPV, 1);
        for col_idx=1:n
            selected_vec = Vec((col_idx-1)*Size_TMPV+1:col_idx*Size_TMPV);
            if row_idx > col_idx
                difference = row_idx - col_idx;
                selected_col = Col(1+difference*Size_TMPV:(difference+1)*Size_TMPV);
                selected_row = flip(Col(2+(difference-1)*Size_TMPV:1+difference*Size_TMPV));
            elseif row_idx < col_idx
                difference = col_idx - row_idx;
                selected_row = Row(1+difference*Size_TMPV:(difference+1)*Size_TMPV);
                selected_col = flip(Row(2+(difference-1)*Size_TMPV:1+difference*Size_TMPV));
            else
                selected_row = Row(1:Size_TMPV);
                selected_col = Col(1:Size_TMPV);
            end
            c_tmpv2 = TMVP2_multiplier(selected_col, selected_row, selected_vec, Size_TMPV);
            result_temp = result_temp + c_tmpv2;
        end
        c((row_idx-1)*Size_TMPV+1:row_idx*Size_TMPV) = result_temp;
    end
end

