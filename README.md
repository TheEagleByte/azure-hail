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

13. Save the changes and restart the affected services. These changes need a restart of Spark2 service. Ambari UI will prompt a required restart reminder, click Restart to restart all affected services.
14. To add the new virtual environment to jupyter notebook, go to the Azure dashboard for your HDInsight cluster
15. Open the Script Actions Tab
16. Add a new custom script action only for the header nodes to set the jupyter notebook instance to use the new hail environment with a link to a copy of `set-jupyter-to-hail.sh`
17. Wait for the script to complete
18. You have successfully completed configuration of the cluster to run hail
