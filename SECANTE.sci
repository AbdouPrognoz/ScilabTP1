function [y, n, Table] = SECANTE(r0, r1, fonc, max_iter)
    x_prev = r0;
    x_curr = r1;
    Table = [];
    
    f_prev = fonc(x_prev);
    f_curr = fonc(x_curr);
    
    Table = [Table; 0, x_prev, f_prev, abs(x_curr - x_prev)];
    
    for i = 1:max_iter
        if abs(f_curr - f_prev) < 1e-14 then 
            error("Division by zero in Secant method."); 
        end
        
        x_next = x_curr - f_curr * (x_curr - x_prev) / (f_curr - f_prev);
        diff_x = abs(x_next - x_curr);
        
        Table = [Table; i, x_curr, f_curr, diff_x];
        
        x_prev = x_curr;
        x_curr = x_next;
        f_prev = f_curr;
        f_curr = fonc(x_curr);
    end
    
    n = max_iter;
    //Table = [Table; n, x_curr, f_curr, 0];
    y = x_curr;
endfunction
