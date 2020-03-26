# azure-hail
Hail On Azure using HDInsights

# Instructions
1. Create an Azure Managed Identity
2. Create an Azure Data Lake Storage Gen2 instance
3. Add the Managed Identity to be the storage instance with "Storage Blob Data Owner" role
4. Create an HDInsight Cluster with the type of "Spark" with version 2.4
5. Add a Script Action to the configuration tab with a link to a copy of `hail-install.sh`
6. Wait for the cluster to reach a "Running" status
7. Open the Apache Ambari Dashboard on the HDInsight Cluster
8. Go to the page for `Spark2` by clicking it on the left panel
9. Open the config tab and expand the `Advanced livy2-env` tab
10. Append the following to the bottom of the configuration content box:

```
export PYSPARK_PYTHON=/usr/bin/anaconda/envs/hail/bin/python3.7
export PYSPARK_DRIVER_PYTHON=/usr/bin/anaconda/envs/hail/bin/python3.7
```

11. Expand the `Advanced spark2-env` tab
12: Replace the last line exporting `PYSPARK_PYTHON` with the following line:

```
export PYSPARK_PYTHON=${PYSPARK_PYTHON:-/usr/bin/anaconda/envs/hail/bin/python3.7}
```

13. Append the following to the end of the line starting with `export SPARK_DIST_CLASSPATH=...`:

```
/usr/bin/anaconda/envs/hail/lib/python3.7/site-packages/hail/hail-all-spark.jar:
```

14. Expand the `Custom spark2-defaults` tab
15. Click `Add Property ...` at the bottom of the list
16. Input `spark.kryo.registrator` for the `key` property
17. Input `is.hail.kryo.HailKryoRegistrator` for the `value` property
18. Select `Text` for the property type
19. Click `Add` to append to the end of the list
20. Do the same (steps 15 - 19) for the next 3 items:

| Key | Value |
| ----------------------------- | ------------------------------------------------------------------------------- |
| spark.jars                    | /usr/bin/anaconda/envs/hail/lib/python3.7/site-packages/hail/hail-all-spark.jar |
| spark.driver.extraClassPath   | /usr/bin/anaconda/envs/hail/lib/python3.7/site-packages/hail/hail-all-spark.jar |
| spark.executer.extraClassPath | ./hail-all-spark.jar                                                            |

21. Save the changes and restart the affected services. These changes need a restart of Spark2 service. Ambari UI will prompt a required restart reminder, click Restart to restart all affected services.
22. To add the new virtual environment to jupyter notebook, go to the Azure dashboard for your HDInsight cluster
23. Open the Script Actions Tab
24. Add a new custom script action only for the header nodes to set the jupyter notebook instance to use the new hail environment with a link to a copy of `set-jupyter-to-hail.sh`
25. Wait for the script to complete
26. You have successfully completed configuration of the cluster to run hail
