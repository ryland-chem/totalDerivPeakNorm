%csv is too complex, need to convert to tab delimited text file, doing this
%by converting every file in the current directory (directory) to a .txt in
%the directory temp.

%will write another function to delete this temp file later once all the
%calculations have been performed

function convertCSVtoTXT(NewDirectory)

    %change directory to 'NewDirectory' if not done so already
    cd(NewDirectory);

    %create temp folder
    tempFolder = 'temp';
    %double check that the temp folder does not exist and make it
    if exist(tempFolder, 'dir')
        rmdir(tempFolder, 's');
        mkdir(tempFolder);
    elseif ~exist(tempFolder, 'dir')
        mkdir(tempFolder);
    end

    csvFiles = dir('*.csv');

    %Loop through each .csv file, convert, and save in the "temp" folder
    for i = 1:length(csvFiles)
        % Get the current .csv file name
        csvFileName = csvFiles(i).name;
        
        % Construct the full path to the .csv file
        csvFilePath = fullfile(pwd, csvFileName);

        % Create import options with 'VariableNamingRule' set to 'preserve'
        importOptions = delimitedTextImportOptions('VariableNamingRule', 'preserve', 'Delimiter', ',');
        
        % Read the .csv file
        data = readtable(csvFilePath, importOptions);
        
        % Construct the full path for the .txt file in the "temp" folder
        txtFileName = strrep(csvFileName, '.csv', '.txt');
        txtFilePath = fullfile(tempFolder, txtFileName);
        
        % Write the data to the .txt file with tab delimiter
        writetable(data, txtFilePath, 'Delimiter', '\t');
    end

end