# totalDerivPeakNorm

## Seo Lin Nam, Ryland T. Giebelhaus, Kieran Tarazona Carrillo, A. Paulina de la Mata, James J. Harynuk (2023)

This is a MATLAB function which takes peak tables from .txt (tab delimited) files (or .csv if you trust your software to not separate based on chemical names with commas) and calculate the total peak area and total derivitized peak area using logical scripts. For processing GC-MS and GCxGC-MS data.

This tool requires users to have peak tables with compound name, total peak area, and deconvolved mass spectra for each analyte, where the mass spectrum is in the format of "70:1231 71:322 72:2334..." where the colon separates mz from intensity [mz:intensity]. This is standard for lots of vendor softwares. See the attached demo peak table (demo.csv).

### Instructions
1) Download the GitHub repository and unzip (v1.0)
2) All of the MATLAB for this function runs from `mainTDPA.m`, all other files are dependencies.
3) in `mainTDPA` 3 variables are required, `myDirectory` is the directory containing the .csv or .txt files, `csvMode` is if you are looking for .csv files (more work is needed for these since MATLAB prefers .txt tab delimited), if using .csv set to 1, otherwise 0. `fileOutName` is the name of the .csv file containing TDPA (total derivitized peak area) and TPA (total peak area) for each sample, just specify.
4) Sit back and allow program to process samples.

NOTE: MATLAB will sometimes flash a red error message about column headers but allow the code to continue running, this will not impact the output results.

### Troubleshooting
For troubleshooting please contact rgiebelh@ualberta.ca or james.harynuk@ualberta.ca
