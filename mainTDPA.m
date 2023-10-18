%function to compute the TDPA of a stack of processed chromatograms without
%using scripts in the vendor software. 

%if your files are in .csv files, csvMode == 1, if .txt tab delimited
%(preferred due to chemical names with commas) csvMode == 0. If throws an
%error, likely that either indexing for quant ion isnt correct (6th column)
%or mass spectra (11th column) OR the data is misformatted due to an issue
%with the .csv and names.

function [structOut] = mainTDPA(myDirectory, csvMode, fileOutName)

    %calling the function to convert everything to the temp dir if the
    %csvMode == 1, now everything is in a temp directory
    if csvMode == 1
    
        convertCSVtoTXT(myDirectory);
        %convert the directory to the temp file now
        %access all file names in that directory
        %specify the base and sub directory
        baseDirectory = myDirectory;
        subDirectory = 'temp';
        %define fullPath
        fullPath = fullfile(baseDirectory, subDirectory);
    
    else

        fullPath = myDirectory;
    
    end
    
    %call the import data function to read in the data, everything will be
    %.txt from here on in, any .txt files in the directory that were not
    %.csv before will get eated and toss an error!
    [tdpaOutTable, peakTableStruct] = importData(fullPath);
    
    %delete that temp folder if we had to make it
    if csvMode == 1

        rmdir(fullPath, 's');

    end

    %write table as a file
    writetable(tdpaOutTable, fileOutName);

    structOut = struct();

    structOut.normFactors = tdpaOutTable;
    structOut.peakTables = peakTableStruct;

end