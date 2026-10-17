function [y, n, Table] = OSTROWSKI(f, df, x0, e)
    x = x0; n = 0; diff_x = e + 1; max_iter = 500; Table = [];
    while (diff_x >= e) & (n < max_iter)
        fx = f(x); dfx = df(x);
        if dfx == 0 then error("Derivative zero."); end
        yn = x - (fx / dfx);
        fyn = f(yn);
        denom = fx - 2 * fyn;
        if denom == 0 then error("Denominator zero."); end
        x_next = yn - (fx / denom) * (fyn / dfx);
        diff_x = abs(x_next - x);
        Table = [Table; n, x, fx, diff_x];
        x = x_next; n = n + 1;
    end
    Table = [Table; n, x, f(x), 0]; y = x;
endfunction
