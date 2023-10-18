%to do
%has issue with commas in names of compounds, deal with that
%need to extract quant mass and mass spectra

function [tdpaTable, peakTableStruct] = importData(fullPath)

    %get the name of all .txt files
    dirContents = dir(fullfile(fullPath, '*.txt'));

    %get the file names
    txtFileNames = {dirContents.name};

    %initalize the tdpa array
    tdpaArray = [];
    tpaArray = [];

    %structure of tables
    peakTableStruct = struct();

    %read in one file as a table, need to delete the first row and extract
    %the columns and save, will only need table once so can trash it after
    %by clearing from workspace
    for k = 1:length(txtFileNames)

        fprintf('Processing file %d of %d\n', k, length(txtFileNames));
        
        %find the file name from the path
        indivFilePath = fullfile(fullPath, txtFileNames{k});

        %extract the peak table as peakTable
        peakTable = readtable(indivFilePath, 'Delimiter', '\t');

        %delete first row
        peakTable(1, :) = [];

        %adding another function here to (1) process MS into table with m/z
        %and intensity (2) sort for most intense, (3) apply scripts, (4)
        %return logical for if script match and also quant ion intensity
        [tdpaSample, peakTableOut] = massSpecLogic(peakTable);

        tpaSample = sum(peakTable.Area);

        %jam tdpaSample into a table with the sample name
        tdpaArray(k) = tdpaSample; %#ok
        tpaArray(k) = tpaSample; %#ok

        
        fieldNameOut = strrep(['normOutput_', txtFileNames{k}], ' ', '_');
        fieldNameOut = strrep(fieldNameOut, '.', ''); % Remove periods

        peakTableStruct.(fieldNameOut) = peakTableOut;

    end

    %have to convert
    tdpaArray = tdpaArray';
    tdpaArrayTable = array2table(tdpaArray);
    
    tpaArray = tpaArray';
    tpaArrayTable = array2table(tpaArray);

    %convert txt too
    txtFileNames = txtFileNames';
    txtFileNamesTable = cell2table(txtFileNames);

    tdpaTable = [txtFileNamesTable, tdpaArrayTable, tpaArrayTable];
    %tdpaTable = cell2table(tdpaTable);
    tdpaTable.Properties.VariableNames = {'SampleName', 'TDPA', 'TPA'};

end