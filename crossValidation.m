function crossValidation(Y,Sd,St,classifier,cv_setting,m,n,use_WKNKN,K,eta,use_W_matrix)


    % prediction method
    pred_fn = str2func(['alg_' classifier]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% cross validation setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % parameters
    fprintf('m = %i\n',m);      % #repetitions
    fprintf('n = %i\n',n);      % #folds

    % seeds
    rng('shuffle');
    seeds = randi(10000,1,m);

    % print seeds to be used...
    fprintf('seeds = [  ');
    for s=1:length(seeds)
        fprintf('%i  ',seeds(s));
    end
    fprintf('  ]\n\n');
    disp('==========================');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % cross validation (m repetitions of n-fold experiments)
    AUCs  = zeros(1,m);
    AUPRs = zeros(1,m);
    for i=1:m
        seed = seeds(i);
        [AUCs(i), AUPRs(i)] = nfold(Y,Sd,St,pred_fn,n,seed,cv_setting,use_WKNKN,K,eta,use_W_matrix);
        diary off;  diary on;
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % display evaluation results
    fprintf('\n FINAL AVERAGED RESULTS\n\n');
    fprintf('     AUC (std): %g\t(%g)\n',   mean(AUCs),  std(AUCs));
    fprintf('    AUPR (std): %g\t(%g)\n',   mean(AUPRs), std(AUPRs));
    diary off;  diary on;

end