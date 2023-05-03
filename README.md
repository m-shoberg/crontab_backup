# crontab_backup
A simple shell script which automatically backs up files that have been updated within the past 24 hours.


Download the following zip file with the wget command:
<pre><code>wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/important-documents.zip</code></pre>


Unzip the archive file: (-DDo to overwrite and not restore original modified date)
<pre><code>unzip -DDo important-documents.zip</pre></code>


Update the file’s last modified date to now:
<pre><code>touch important-documents/*</pre></code>


Given that the script takes two arguments as input, you can run the script using the following command. This this will create a backup file called backup-[CURRENT_TIMESTAMP].tar.gz in your current directory.:
<pre><code>./backup.sh important-documents .</pre></code>





You can view the current backup schedule using the following command:
<pre><code>crontab -l</pre></code>


You can edit the backup schedule using the following command:
<pre><code>crontab -e</pre></code>
