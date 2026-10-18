function PerformanceTable = compare_methods(f, df, x0_newton, r0_secant, r1_secant, e, max_iter)
    // 1. Run all three methods (Notice r0_secant and r1_secant come BEFORE f)
    [root_N, iter_N, Table_N] = NEWTON(f, df, x0_newton, e);
    [root_S, iter_S, Table_S] = SECANTE(r0_secant, r1_secant, f, max_iter);
    [root_O, iter_O, Table_O] = OSTROWSKI(f, df, x0_newton, e);

    // 2. Extract final residual accuracy |f(x*)|
    res_N = abs(f(root_N));
    res_S = abs(f(root_S));
    res_O = abs(f(root_O));

    // 3. Efficiency Indices E = p^(1/m)
    E_S = 1.618^(1/1);
    E_N = 2.0^(1/2);
    E_O = 4.0^(1/3);

    // Assemble performance matrix: [Total Iterations, Final Residual |f(x*)|, Efficiency Index E]
    PerformanceTable = [
        iter_S, res_S, E_S;
        iter_N, res_N, E_N;
        iter_O, res_O, E_O
    ];

    // Print styled comparison table for Section 4.4
    mprintf("\n=========================================================================\n");
    mprintf("                    SECTION 4.4: PERFORMANCE COMPARISON                  \n");
    mprintf("=========================================================================\n");
    mprintf("  Method       | Total Iterations (N) | Final Accuracy |f(x*)| | Efficiency Index (E)\n");
    mprintf("-------------------------------------------------------------------------\n");
    mprintf("  Secant       | %20d | %22.10e | %20.4f\n", PerformanceTable(1,1), PerformanceTable(1,2), PerformanceTable(1,3));
    mprintf("  Newton       | %20d | %22.10e | %20.4f\n", PerformanceTable(2,1), PerformanceTable(2,2), PerformanceTable(2,3));
    mprintf("  Ostrowski    | %20d | %22.10e | %20.4f\n", PerformanceTable(3,1), PerformanceTable(3,2), PerformanceTable(3,3));
    mprintf("=========================================================================\n");
endfunction
