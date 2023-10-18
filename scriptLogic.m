function [logicOut] = scriptLogic(massSpecTable)

    %just sort again to be careful
    massSpecTable = sortrows(massSpecTable, -2);
    
    %extract the mzs
    massSpecMZs = table2array(massSpecTable(:,1));

    %define logic out
    logicOut = 0; %#ok

    %apply logic rules here
    if massSpecMZs(1) == 73 || massSpecMZs(2) == 73 || massSpecMZs(3) == 73

        logicOut = 1;

    elseif massSpecMZs(1) == 75 || massSpecMZs(2) == 75

        logicOut = 1;

    elseif massSpecMZs(1) == 43 || massSpecMZs(1) == 147

        logicOut = 1;

    else

        logicOut = 0;

    end

end
