The `mimetype` file needs to be stored without compression in the zip archive that is the ODS file. This allows software to detect the file type easily.

I'm not sure if there's an easy way in R to store a file in a zip without compression, so my plan is to use the zip file here as a starting point for the ODS file, then append the other files (compressed) to it using R.
