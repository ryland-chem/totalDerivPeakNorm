function [tdpaSample, peakTableOut] = massSpecLogic(peakTable)

    %store data as tables
    quantMasses = peakTable(:, 5);
    massSpectra = peakTable(:, 11);
    areasPeak = peakTable(:, 9);

    %convert massSpectra to cell array (save processing power).
    cellMassSpectra = table2cell(massSpectra);
    %convert the quantMasses to cell array
    %quantMassesCell = table2cell(quantMasses);
    areasPeakArray = table2array(areasPeak);

    %create a running total for TDPA
    tdpaSample = 0;

    %count total logic
    countLogic = zeros(length(cellMassSpectra), 1);

    disp('Processing mass spectra');

    for ii = 1:length(cellMassSpectra)
        
        %initalize mzs and intensities
        mzs = 0;
        intent = 0;
        massSpecTable = table(mzs, intent);
        massSpecTable.Properties.VariableNames = {'MZs', 'Intensities'};
        rowEntryArray = []; %#ok
        
        %pull out an individual MS as a cell
        cellMS = cellMassSpectra(ii,:);
        
        %first split on the space
        pairsCell = strsplit(cellMS{1}, ' ');

        for jj = 1:length(pairsCell)
            
            %split up the individual pairs
            individPairColon = strsplit(pairsCell{jj}, ':');

            %convert to integer and feed into the massSpecTable
            rowEntryArray = [str2double(individPairColon{1}), str2double(individPairColon{2})];

            massSpecTable{jj, :} = rowEntryArray;

        end

        %do logic test here on the data
        %first sort the data (sorting by intensities)
        sortMassSpecTable = sortrows(massSpecTable, -2);

        %now apply logic
        [logicOut] = scriptLogic(sortMassSpecTable);

        %only if logic out is 1 do we do anythign with the quant ion
        if logicOut == 1

            %quantIonString = strrep(quantMassesCell{i}, '"', '');
            %quantIoni = str2double(quantIonString);
% 
            indexQuantIon = find(sortMassSpecTable.MZs == table2array(quantMasses(ii, 1)), 1);
% 
            quantIonIntent = sortMassSpecTable.Intensities(indexQuantIon); %#ok
% 
%             tdpaSample = tdpaSample + quantIonIntent;

            tdpaSample = tdpaSample + areasPeakArray(ii);

            countLogic(ii) = 1;

        else

            tdpaSample = tdpaSample; %#ok

        end


    end

    countLogic = array2table(countLogic);
    countLogic.Properties.VariableNames = {'Classification'};

    peakTableOut = [peakTable, countLogic];

end