function c = Main_Multiplier_New(Col, Row, Vec, Size_TMPV, max_n)
    % Initialization
    L = length(Vec);
    c = zeros(L, 1);
    % check the end
    if (L == Size_TMPV)
        c = TMVP2_multiplier(Col, Row, Vec, L, max_n);
    else
        if (L == 720 || L == 864 || L == 240 || L == 288)
            row_a0 = Row(2*L/3+1:L);
            row_a1 = Row(L/3+1:2*L/3);
            row_a2 = Row(1:L/3);
            row_a3 = flip(Col(2:L/3+1));
            row_a4 = flip(Col(2+L/3:2*L/3+1));
            col_a0 = flip(Row(2+L/3:2*L/3+1));
            col_a1 = flip(Row(2:L/3+1));
            col_a2 = Col(1:L/3);
            col_a3 = Col(L/3+1:2*L/3);
            col_a4 = Col(2*L/3+1:L);
            row_a1_a2 = mod(row_a1 + row_a2, max_n);
            col_a1_a2 = mod(col_a1 + col_a2, max_n);
            row_a0_a1_a2 = mod(row_a1_a2 + row_a0, max_n);
            col_a0_a1_a2 = mod(col_a1_a2 + col_a0, max_n);
            row_a1_a2_a3 = mod(row_a1_a2 + row_a3, max_n);
            col_a1_a2_a3 = mod(col_a1_a2 + col_a3, max_n);
            row_a2_a3_a4 = mod(row_a2 + row_a3 + row_a4, max_n);
            col_a2_a3_a4 = mod(col_a2 + col_a3 + col_a4, max_n);
            vec_b0 = Vec(1:L/3);
            vec_b1 = Vec(L/3+1:2*L/3);
            vec_b2 = Vec(2*L/3+1:L);
            vec_b1_b2 = mod(vec_b1 - vec_b2, max_n);
            vec_b0_b2 = mod(vec_b0 - vec_b2, max_n);
            vec_b0_b1 = mod(vec_b0 - vec_b1, max_n);
            M1 = Main_Multiplier_New(col_a1, row_a1, vec_b1_b2, Size_TMPV, max_n);
            c_m_1 = M1;
            c_m_2 = -M1;
            M2 = Main_Multiplier_New(col_a0_a1_a2, row_a0_a1_a2, vec_b2, Size_TMPV, max_n);
            c_m_1 = c_m_1 + M2;
            M3 = Main_Multiplier_New(col_a1_a2_a3, row_a1_a2_a3, vec_b1, Size_TMPV, max_n);
            c_m_2 = c_m_2 + M3;
            M4 = Main_Multiplier_New(col_a2, row_a2, vec_b0_b2, Size_TMPV, max_n);
            c_m_1 = c_m_1 + M4;
            M5 = Main_Multiplier_New(col_a3, row_a3, vec_b0_b1, Size_TMPV, max_n);
            c_m_2 = c_m_2 + M5;
            M6 = Main_Multiplier_New(col_a2_a3_a4, row_a2_a3_a4, vec_b0, Size_TMPV, max_n);
            c_m_3 = M6 - M4 - M5;
            c = mod([c_m_1; c_m_2; c_m_3], max_n);
        else
            vec_b0 = Vec(1:L/2);
            vec_b1 = Vec(L/2+1:L);
            vec_b0_plus_b1 = mod(vec_b0 + vec_b1, max_n);
            row_a0 = Row(1:L/2);
            col_a0 = Col(1:L/2);
            row_a1 = flip(Col(2:L/2+1));
            col_a1 = Col(L/2+1:L);
            row_a2 = Row(L/2+1:L);
            col_a2 = flip(Row(2:L/2+1));
            row_a2_minus_a0 = mod(row_a2 - row_a0, max_n);
            col_a2_minus_a0 = mod(col_a2 - col_a0, max_n);
            a0_b0_plus_b1 = Main_Multiplier_New(col_a0, row_a0, vec_b0_plus_b1, Size_TMPV, max_n);
            a2_minus_a0_b1 = Main_Multiplier_New(col_a2_minus_a0, row_a2_minus_a0, vec_b1, Size_TMPV, max_n);
            c_m_1 =  mod(a0_b0_plus_b1 + a2_minus_a0_b1, max_n);
            row_a1_minus_a0 = mod(row_a1 - row_a0, max_n);
            col_a1_minus_a0 = mod(col_a1 - col_a0, max_n);
            a1_minus_a0_b0 = Main_Multiplier_New(col_a1_minus_a0, row_a1_minus_a0, vec_b0, Size_TMPV, max_n);
            c_m_2 = mod(a0_b0_plus_b1 + a1_minus_a0_b0, max_n);
            c = [c_m_1; c_m_2];
        end
    end
    
end

