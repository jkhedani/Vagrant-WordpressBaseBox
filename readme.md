How to Use baseBoxForDev
========================

+  Duplicate baseBoxForDev and re-name as project
+  Edit /Vagrantfile and set parameter "config.vm.network :hostonly" to a new IP. (Choose an IP that doesn't conflict with other builds)
		$ vagrant up
+  Create database for wordpress: http://192.168.10.X0/phpmyadmin/
+  Copy and edit your local configuration:
		$ cd /projectName/www
		$ cp local-config-sample.php local-config.php
+  Update Wordpress:
		$ cd /projectName/www/wp
		$ git fetch --tags
		$ git checkout t.a.g
+  Download master theme:
		$ cd /projectName/www/content/themes
		$ git clone https://github.com/jkhedani/Wordpress-Bedrock-Theme.git bedrock
+  Utilize the child theme:
		$ cp /projectName/samplechildtheme projectName
+  Go to http://192.168.10.X0/wp to start building!
