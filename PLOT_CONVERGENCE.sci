function PLOT_CONVERGENCE(f, df, x0, r0, r1, e, num_iter)
    [yn, nn, Tab_N] = NEWTON(f, df, x0, e);
    [ys, ns, Tab_S] = SECANTE(r0, r1, f, num_iter);
    [yo, no, Tab_O] = OSTROWSKI(f, df, x0, e);
    
    n_n = Tab_N(:, 1); fn_n = Tab_N(:, 3);
    n_s = Tab_S(:, 1); fn_s = Tab_S(:, 3);
    n_o = Tab_O(:, 1); fn_o = Tab_O(:, 3);
    
    scf(0);
    clf();
    
    plot2d(n_n, log10(abs(fn_n)), style=2); 
    plot2d(n_s, log10(abs(fn_s)), style=5); 
    plot2d(n_o, log10(abs(fn_o)), style=3); 
    
    xtitle("Convergence Comparison (Semi-Log Scale)", "Iteration Index (n)", "log10(|f(x_n)|)");
    legend(["Newton Method"; "Secant Method"; "Ostrowski Method"]);
endfunction
