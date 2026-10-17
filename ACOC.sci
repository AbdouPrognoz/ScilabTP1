function ACOC_Table = ACOC(Table)
    // Input:  Table = [n, x_n, f(x_n), d_n] (4 columns)
    // Output: ACOC_Table = [n, x_n, d_n, r_n, ln(r_n), p_n] (6 columns)

    N = size(Table, 1);
    
    // Extract column vectors from input Table
    n_vec = Table(:, 1);
    x_vec = Table(:, 2);
    d_vec = Table(:, 4); // d_n = |x_{n+1} - x_n|

    // Initialize output vectors with %nan (Not a Number) for undefined steps
    r_vec    = %nan * ones(N, 1);
    ln_r_vec = %nan * ones(N, 1);
    p_vec    = %nan * ones(N, 1);

    // Compute r_n = d_n / d_{n-1} and ln(r_n) starting from row 2 (n = 1)
    for i = 2:N
        if (d_vec(i-1) ~= 0) & (~isnan(d_vec(i-1))) then
            r_vec(i) = d_vec(i) / d_vec(i-1);
            if r_vec(i) > 0 then
                ln_r_vec(i) = log(r_vec(i)); // log() in Scilab is natural log ln()
            end
        end
    end

    // Compute p_n = ln(r_n) / ln(r_{n-1}) starting from row 3 (n = 2)
    for i = 3:N
        if (~isnan(ln_r_vec(i-1))) & (ln_r_vec(i-1) ~= 0) & (~isnan(ln_r_vec(i))) then
            p_vec(i) = ln_r_vec(i) / ln_r_vec(i-1);
        end
    end

    // Assemble final 6-column matrix
    ACOC_Table = [n_vec, x_vec, d_vec, r_vec, ln_r_vec, p_vec];
endfunction
