# assignment

Space X application servers run a custom-built application on Ubuntu 20.04 LTS. Unfortunately, sometimes the application will:
1.	crash
2.	fail to respond to a HTTP request at port 8080 (at a /status/ URI), or
3.	use more than 5GB of memory (which causes the operating system to fail), or
4.	use more than 90% of the CPU for over 1 minute
Whenever either of those situations happens, the application must be restarted.

Please write a linux bash script or Python script that, when run, will automatically terminate and restart the application when any of those situations occur.
