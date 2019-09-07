GET DATA
  /TYPE=TXT
  /FILE='C:\Users\acosa\Dropbox\PhD Andrea Caso 12801678\Dissertation\Dissertation chapters\Chapter 7\Code WCST\wcst_ch7.txt'
  /DELCASE=LINE
  /DELIMITERS="\t"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  TE F12.6
  PE F12.6
  SL3 F12.6
  Group F12.6
.

SAVE OUTFILE='C:\Users\acosa\Dropbox\PhD Andrea Caso 12801678\Dissertation\Dissertation chapters\Chapter 7\Code WCST\wcst_ch7.sav'
/COMPRESSED