README for Processing Pipeline of Continuous Monitoring
Authors: Daniel Cox (CDFW), Emma Mendonsa (DWR)
Date: 230717


The Processing.Rproj contains scripts to import, manipulate, and score continuous sonde data.  

First, the script named 'ContinuousSonde_Processing.Rmd' imports datasets the datasets and splits it up into a list of usable dataframes and a list of metadata.

Then, 'SondeWorksheets.Rmd' imports sonde exchange and calibration worksheets. These worksheets are based from DWR programmatic worksheets that were modified for use in Survey123. Currently, the team from DWR's side of FRP does not use Survey123 and we must import a different file with all the compiled exchange and calibration data.

'ErrorCalculations.Rmd' uses measurements from the sonde exchange and calibrations to calculate the error associated with fouling and sensor drift. Quality scores are then given to each variable based on the criteria used by DWR programs.

Finally, we return to 'ContinuousSonde_Processing.Rmd' to trim the datasets to the correct time period based on sonde exchange times. Trimming also takes place using tell-tale observations for certain sensors that show it was measuring in air. After trimming, the each variable in each dataset is matched to the quality scores.

After the initial error QC, the data are then passed through a secondary QC script adopted from Catarina Pien used in the data cleaning code, WaterTemp_QC.Rmd, found in edi.591.2

Figures are then generated to look at each constituent on a station-by-station basis. Original data are shown in red overlaid with data that passed QC checks shown in black.

The 'raw' folder contains "DWR_ErrorTransferWorksheet_Kiana.xlsx", which is manually updated in GitHub by grabbing it from DWR's SharePoint (C:\Users\DCox\California Department of Water Resources\DWR - Fish Restoration Program - Water Quality Lab\Data Processing\DriftCals_toCDFW)

The 'raw' folder contains "SondeData_StartStopTimes.xlsx", which is manually updated in GitHub by grabbing it from DWR's SharePoint (C:\Users\DCox\California Department of Water Resources\DWR - Fish Restoration Program - Water Quality Lab\Data Processing)
