
- [Guide](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html)
  - [Download](http://www.apache.org/dyn/closer.cgi/hadoop/common/)

- Comma-Separated Values (CSV), [RFC 4180](https://datatracker.ietf.org/doc/html/rfc4180)
  - [Hive](https://github.com/apache/hive/blob/master/serde/src/java/org/apache/hadoop/hive/serde2/OpenCSVSerde.java) uses [OpenCSV](https://opencsv.sourceforge.net/) for serializing and deserializing data to and from CSV files. 
  - The Hive [beeline](https://cwiki.apache.org/confluence/display/hive/hiveserver2+clients#HiveServer2Clients-Separated-ValueOutputFormats "Starting with Hive 0.14 there are improved SV output formats available, namely dsv, csv2 and tsv2.") client employs [Super CSV](https://super-csv.github.io/super-csv/index.html) for CSV output. This dependency is adopted from [SQLLine](https://github.com/apache/hive/blob/master/beeline/src/java/org/apache/hive/beeline/SeparatedValuesOutputFormat.java).
  - DBeaver uses its own [CSV Exporter](https://github.com/dbeaver/dbeaver/blob/devel/plugins/org.jkiss.dbeaver.data.transfer/src/org/jkiss/dbeaver/tools/transfer/stream/exporter/DataExporterCSV.java).

