function GetTime()
{
  t = substr($2,5,length($2)-4)
  return(t)
}
#
# Calculate the average amount of time required to produce a timestamp
#
function BegAvgDelta()
{
       elapsed = 0
       count   = 0
       skip = 1
       for(;;)
       {
         getline
         mystr = substr($0,1,3)
         if (mystr == "# #")
         {
           if (!skip)
           {
             elapsed += GetTime()
             count++
           }
           else skip = 0
         }
         if (index($0,"ENDAVGDELTA"))
         {
           EndComment = sprintf("%s %s %s %s %s %s %s %s %s                  ",
                          $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
           EndComment = substr(EndComment ,1,desclen)
           getline
           break
         }
       }
       printf("Time Stamp Delta: %8.6f\t%s\n\n", elapsed/count, EndComment)
       return(elapsed/count)
}
#
# Process a timestamp
#
function TimeStamp()
{
       desclen = 36                             # characters to print in
                                                # descriptive text
       et = substr($2,5,length($2)-4)                 #extract elapsed time
       et -= tmdelta
       desc = sprintf("%s %s %s %s %s %s %s %s %s                        ",
                      $4,$5,$6,$7,$8,$9,$10,$11,$12)
       desc = substr(desc,1,desclen)
#
# See if the 3rd token contains a digit; if so, this timestamp is
# to be treated as one to be averaged
      getavg = 0
      if (i = match($3,/[0-9]/))
      {
        getavg = 1
        avg = et/$3
      }
#
# See if the "ROW" keyword appears in the description; if so, save the time
# in the appropriate array element
      array = 0
      if ($3 == "ROW")
      {
        row = $4 + 0
        col = $6 + 0
        array = 1
      }
      if ($4 == "ROW")
      {
        row = $5 + 0
        col = $7 + 0
        array = 1
      }
      if (array)
      {
        elt[row,col] = et
        if (getavg)
           elt[row,col] = avg
      }
#
# If we are to calculate an average but not put it in an array then do it now
      if (getavg && !array)
      {
        printf("\n\t\t\t\t\tCount\tElapsed\tAverage\n")
        printf("%s\t%3d\t%5.2f\t%5.2f\n\n", desc, $3, et, avg)
      }
#
# Print a plain timestamp with its description (no averaging, no array)
      if (!getavg && !array)
      {
        desc = $3 " " desc
        desc = substr(desc,1,desclen)
        printf("%s\t%5.2f\n", desc, et)
      }
}
#
# Get the number of columns and save the heading text
#
function ColHeading()
{
  cCol = $2 + 0
  desc = sprintf("%s %s %s %s %s %s %s %s %s                        ",
                 $3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
  for(i=1; i <= cCol; i++)
  {
    ndx = index(desc,";")                       # heading text is delimited
                                                # by a semi-colon
    if (!ndx) ndx = length(desc)
    ColHead[i] = substr(desc,1,ndx-1)
    desc = substr(desc,ndx+1)
    for(;;)                                     # strip off leading blanks
    {
      if (substr(desc,1,1) == " ")
        desc = substr(desc,2,length(desc)-1)
      else
        break
    }
  }
}
#
# Get the number of rows and save the descriptive text
#
function RowText()
{
  cRow  = $2 + 0
  desc = sprintf("%s %s %s %s %s %s %s %s %s                        ",
                 $3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
  for(i=1; i <= cRow; i++)
  {
    ndx = index(desc,";")                       # descriptive text is delimited
                                                # by a semi-colon
    if (!ndx) ndx = length(desc)
    szRowText[i] = substr(desc,1,ndx-1) blanks    # Make each description a
    szRowText[i] = substr(szRowText[i],1,desclen) # fixed number of characters
                                                  # in length
    desc = substr(desc,ndx+1)
    for(;;)                                     # strip off leading blanks
    {
      if (substr(desc,1,1) == " ")
        desc = substr(desc,2,length(desc)-1)
      else
        break
    }
  }
}
#
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#
BEGIN {
  tmdelta = 0
  desclen = 36          # characters to print in descriptive text
  cCol = 0
  cRow = 0
  blanks = "                                             "
}
#
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     {
#
# Process TITLE keyword
#
       if (index($0,"#TITLE"))
       {
         title = sprintf("%s %s %s %s %s %s %s %s %s",
                 $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
         for(;;)                # remove trailing blanks
         {
           x = length(title)
           if (substr(title,x,1) == " ")
             title = substr(title,1,x-1)
           else
             break
         }
         printf("\n*** %s ***\n\n", title)
       }
#
# Process NUMCOLS and NUMROWS keywords
#
       if (index($0,"NUMCOLS")) ColHeading()
       if (index($0,"NUMROWS")) RowText()
#
# Process BEGAVGDELTA/ENDAVGDELTA
#
       if (index($0,"BEGAVGDELTA"))
         tmdelta = BegAvgDelta()        # tmdelta represents the avg amount of
                                        # time to produce a timestamp; it is
                                        # removed from extracted timestamps
                                        # before any caculations are performed
#
# Process timestamp records
#
# If this is a timestamp with descriptive text (ignore timestamps which have
# no descriptive text
       if ((index($0,"# ####")) && (length($3)))
       {
         TimeStamp()
       }
     }
#
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#
END  {
       if (cCol)
       {
         printf("\n\t\t\t\t")
         for(i=1; i <= cCol; i++)
         {
           printf("\t%s", ColHead[i])
         }
         printf("\n%-36s\t%5s\t%5s\n", " ", "-----", "-----")
       }
       if (cRow)
       {
         for(i=1; i <= cRow; i++)
         {
           printf("%s",szRowText[i])
           for(j=1; j <= cCol; j++)
           {
             printf("\t%5.2f", elt[i,j])
           }
           printf("\n")
         }
       }
     }
