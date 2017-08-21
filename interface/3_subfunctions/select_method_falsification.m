function select_method_falsification(choice, seed)

a = choice ;

switch a 
    
    case 1 

         global r
         r = seed ;
        snap_grid = 'y';
        switch snap_grid
            case 'y'
            CBS.SetSnapToGrid(true);
            case 'n'
            CBS.SetSnapToGrid(false);
            otherwise
                error('no epsilon resolution specified')
        end 
               
        loc_time = 1500;
        fprintf('\n Time limit on each local search iteration is %d seconds \n',loc_time);
        
        k = 2;
        fprintf('\n Limit on number of local search iterations is %d\n',k)
 
        timervar_1 = tic;
        time_1 = toc(timervar_1);  
    
    case 2
        time_lim = 5000; 
        fprintf('\n Time limit of computation is %d seconds\n',time_lim)
        snap_grid = 'y';
        switch snap_grid
            case 'y'
            CBS.SetSnapToGrid(true);
            case 'n'
            CBS.SetSnapToGrid(false);
            otherwise
                error('no epsilon resolution specified')
        end
        max_sim = inf;
        fprintf('\n Choose one of the following seeds for pseudorandom sampling:\n')
        r = seed ;
        rng(r,'twister');  
        tic
        Out = StatFalsify(Out, CBS,phi,w_rob,max_sim,max_sim,time_lim);
        time = toc;
        fprintf('Computation time = %f seconds \n',time);
        
    
      
    case 3
        %%
        time_lim = 5000; 
        fprintf('\n Time limit of computation is %d seconds\n',time_lim)
        falsif_pb = FalsificationProblem(CBS, phi);  
        falsif_pb.setup_solver('global_nelder_mead');
        falsif_pb.max_time = time_lim;
        timervar_2 = tic;
        falsif_pb.solve()
        trace = falsif_pb.GetBrSet_False();
        time = toc(timervar_2);
        fprintf('Computation time = %f seconds \n',time);
      
    case 4 
        %%
        time_lim = 5000; 
        fprintf('\n Time limit of computation is %d seconds\n',time_lim)
        delete('var*','outcm*')
        falsif_pb = FalsificationProblem(CBS, phi);  
        falsif_pb.setup_solver('cmaes');
        falsif_pb.solver_options.SaveVariables = 'off';
        fprintf('\n Choose one of the following seeds for pseudorandom sampling:\n')
        r = seed ;
        falsif_pb.solver_options.Seed = r;
        falsif_pb.max_time = time_lim;
        timervar_2 = tic;
        falsif_pb.solve()
        trace = falsif_pb.GetBrSet_False();
        time = toc(timervar_2);
        fprintf('Computation time = %f seconds \n',time);
        if ~isempty(trace)
            trace.PlotSignals
        end
    case 5
        %%
        time_lim = 5000; 
        fprintf('\n Time limit of computation is %d seconds\n',time_lim)
        falsif_pb = FalsificationProblem(CBS, phi);  
        falsif_pb.setup_solver('simulannealbnd');
        falsif_pb.max_time = time_lim;
        timervar_2 = tic;
        falsif_pb.solve()
        trace = falsif_pb.GetBrSet_False();
        time = toc(timervar_2);
        fprintf('Computation time = %f seconds \n',time);
    otherwise
            error('no input')
end     
