#!/bin/bash

### Note: To run the mainthreadio export for a specific day, make a copy of the
###       launch config and change the "job_commandline" value to pass in
###       the desired date as an argument using "./run.sh YYYYMMDD".
###
###       For example, for Jan 2, 2014, you would use "./run.sh 20140102".
###       This will update that day's data in the output bucket as well as
###       updating the weekly aggregate data for the affected week.
###
###       It is important to make a **copy** of the launch config because
###       you don't want to interfere with the nightly cron job.
###
###       You can then launch the job for the specified day by using a 
###       command similar to the "launch_worker" line below.

LOG=~/cron_mainthreadio.log
cd ~/telemetry-server/
echo "Running mainthreadio export for $(date -d 'yesterday' +%Y%m%d)" >> $LOG
time /usr/bin/python -u -m provisioning.aws.launch_worker mapreduce/mainthreadio/mainthreadio_launch_config.json --instance-name mreid-cron-mainthreadio-worker &>> $LOG
echo "Done" >> $LOG
