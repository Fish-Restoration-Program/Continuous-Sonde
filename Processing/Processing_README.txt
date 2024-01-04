README for Processing Pipeline of Continuous Monitoring
Authors: Daniel Cox (CDFW), Emma Mendonsa (DWR)
Date: 230717


The Processing.Rproj contains scripts to import, manipulate, and score continuous sonde data.  

First, the script named 'ContinuousSonde_Processing.Rmd' imports datasets the datasets and splits it up into a list of usable dataframes and a list of metadata.

Then, 'SondeWorksheets.Rmd' imports sonde exchange and calibration worksheets. These worksheets are based from DWR programmatic worksheets that were modified for use in Survey123.

'ErrorCalculations.Rmd' uses measurements from the sonde exchange and calibrations to calculate the error associated with fouling and sensor drift. Quality scores are then given to each variable based on the criteria used by DWR programs.

Finally, we return to 'ContinuousSonde_Processing.Rmd' to trim the datasets to the correct time period based on sonde exchange times. Trimming also takes place using tell-tale observations for certain sensors that show it was measuring in air. After trimming, the each variable in each dataset is matched to the quality scores.

To do: make a new script to assess yearly data for outliers (DMC used one for the Big Report based off of USGS EDI submission)