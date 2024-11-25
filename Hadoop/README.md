
- [Guide](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html)
  - [Download](http://www.apache.org/dyn/closer.cgi/hadoop/common/)

- Hive depends on [OpenCSV](https://opencsv.sourceforge.net/) for table construction of CSV file (see [here](https://github.com/apache/hive/blob/master/serde/src/java/org/apache/hadoop/hive/serde2/OpenCSVSerde.java)), and depends on [Super CSV](https://super-csv.github.io/super-csv/index.html) for output (see [here](https://github.com/apache/hive/blob/afe05b968026dfdda631de1e2b090665f0820ef3/beeline/src/java/org/apache/hive/beeline/SeparatedValuesOutputFormat.java) and [here](https://cwiki.apache.org/confluence/display/hive/hiveserver2+clients#HiveServer2Clients-Separated-ValueOutputFormats "Starting with Hive 0.14 there are improved SV output formats available, namely dsv, csv2 and tsv2.")).

