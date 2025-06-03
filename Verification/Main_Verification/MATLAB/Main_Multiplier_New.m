function c = Main_Multiplier_New(Col, Row, Vec, Size_TMPV)
    % Initialization
    L = length(Vec);
    n = L/Size_TMPV;
    c = zeros(L, 1);
    % check the end
    if (L == Size_TMPV)
        c = TMVP2_multiplier(Col, Row, Vec, L);
    else
        % creating new c, r, and v : 256
        vec_b0 = Vec(1:L/2);
        vec_b1 = Vec(L/2+1:L);
        vec_b0_plus_b1 = vec_b0 + vec_b1;
        row_a0 = Row(1:L/2);
        col_a0 = Col(1:L/2);
        row_a1 = flip(Col(2:L/2+1));
        col_a1 = Col(L/2+1:L);
        row_a2 = Row(L/2+1:L);
        col_a2 = flip(Row(2:L/2+1));
        row_a2_minus_a0 = row_a2 - row_a0;
        col_a2_minus_a0 = col_a2 - col_a0;
        a0_b0_plus_b1 = Main_Multiplier_New(col_a0, row_a0, vec_b0_plus_b1, Size_TMPV);
        a2_minus_a0_b1 = Main_Multiplier_New(col_a2_minus_a0, row_a2_minus_a0, vec_b1, Size_TMPV);
        c_m_1 =  a0_b0_plus_b1 + a2_minus_a0_b1;
        row_a1_minus_a0 = row_a1 - row_a0;
        col_a1_minus_a0 = col_a1 - col_a0;
        a1_minus_a0_b0 = Main_Multiplier_New(col_a1_minus_a0, row_a1_minus_a0, vec_b0, Size_TMPV);
        c_m_2 = a0_b0_plus_b1 + a1_minus_a0_b0;
        c = [c_m_1; c_m_2];
    end
    
end

