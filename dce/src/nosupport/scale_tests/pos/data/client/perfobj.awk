function GetTitle()
{
  for(;;)
  {
    getline
    if ($1 == "#") break
  }
  Title = substr ($0,3,36)

}

function GetStats()
{
# Scan down to statistical summary
  for(;;)
  {
    if (!(rc=getline))
    {
      print "Input file not correct format"
      exit
    }
    if (index($0,"First 5 statistic values"))
    {
      getline
      Stat1  = $1
      Stat2  = $2
      Stat3  = $3
      Stat4  = $4
      Stat5  = $5
      getline
      Mean   = $3
      StdDev = $7
      getline
      Min    = $3
      Max    = $6
      break
    }
  }
}
function Report()
{
  print "-------------------------------------------------------------"
  print Title
  str = sprintf("\t\t\t  1  \t  2  \t  3  \t  4  \t  5  ")
  print str
  str = sprintf("\t\t\t-----\t-----\t-----\t-----\t-----")
  print str
  str = sprintf("\t\t\t%5.2f\t%5.2f\t%5.2f\t%5.2f\t%5.2f", Stat1, Stat2, Stat3, Stat4, Stat5)
  print str
  str = sprintf("   Mean =\t%5.2f", Mean)
  print str
  str = sprintf("   Min  =\t%5.2f", Min )
  print str
  str = sprintf("   Max  =\t%5.2f\n", Max )
  print str
}

BEGIN   {
          print "CDSCP - PERFOBJ\n"
        }

# Main routine
{
  for(i=0; i<10; i++)
  {
    GetTitle()
    GetStats()
    Report()
    if (i == 8) GetTitle()      # skip the 10th set of statistics
  }
#
  exit
}
