function [y, n] = OSTROWSKI(f, df, x0, e)
    // Inputs:
    // f  : function f(x)
    // df : first derivative f'(x)
    // x0 : initial guess
    // e  : tolerance stop criterion (|x_{n+1} - x_n| < e)
    //
    // Outputs:
    // y  : approximate root
    // n  : number of iterations

    x = x0;
    n = 0;
    diff_x = e + 1; // set initial step size > e to enter the loop
    max_iter = 500; // safety max iteration guard

    while (diff_x >= e) & (n < max_iter)
        // Evaluate f and f' at current x
        fx = f(x);
        dfx = df(x);
        
        if dfx == 0 then
            error("Derivative is zero. Algorithm stopped.");
        end

        // Step 1: First intermediate Newton-like step (y_n)
        yn = x - (fx / dfx);

        // Evaluate f at y_n
        fyn = f(yn);

        // Step 2: Ostrowski correction step (x_{n+1})
        denom = fx - 2 * fyn;
        if denom == 0 then
            error("Denominator (f(x_n) - 2*f(y_n)) is zero. Algorithm stopped.");
        end

        x_next = yn - (fx / denom) * (fyn / dfx);

        // Step size for stopping criterion
        diff_x = abs(x_next - x);

        // Update x for next iteration
        x = x_next;
        n = n + 1;
    end

    y = x;
endfunction
