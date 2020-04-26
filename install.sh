#!/bin/sh

daemonsPath=/Library/LaunchDaemons
installdir=/Applications/MAMP/bin
vhostsFile=/Applications/MAMP/conf/apache/extra/httpd-vhosts.conf

# Apply vhost changes
if [ "$(grep xXLXx $vhostsFile)" == "" ]; then
    echo "
# Added by xXLXx
<VirtualHost *:80>
    ServerName dev.*.com
    ServerAlias dev.*.com
    VirtualDocumentRoot "/Applications/MAMP/htdocs/%2/"

    RewriteEngine On

    # Start public_html
    RewriteCond %{SERVER_NAME} ^dev.([^.]+).com$
    RewriteCond %{DOCUMENT_ROOT}/%1/public_html -d
    RewriteRule ^/$ /%1/public_html/index.php [L]

    RewriteCond %{SERVER_NAME} ^dev.([^.]+).com$
    RewriteCond %{DOCUMENT_ROOT}/%1/public_html -d
    RewriteCond %{DOCUMENT_ROOT}/%1/public_html%{REQUEST_FILENAME} -f
    RewriteRule ^/(.*) /%1/public_html%{REQUEST_FILENAME} [L]

    RewriteCond %{SERVER_NAME} ^dev.([^.]+).com$
    RewriteCond %{DOCUMENT_ROOT}/%1/public_html -d
    RewriteCond %{DOCUMENT_ROOT}/%1/public_html%{REQUEST_FILENAME} !-f
    RewriteRule ^/([^/]+).* /%1/public_html/$1/index.php [L]

    # End public_html

    # Start public
    RewriteCond %{SERVER_NAME} ^dev.([^.]+).com$
    RewriteCond %{DOCUMENT_ROOT}/%1/public -d
    RewriteCond %{DOCUMENT_ROOT}/%1/public%{REQUEST_FILENAME} -d [OR]
    RewriteCond %{DOCUMENT_ROOT}/%1/public%{REQUEST_FILENAME} -f
    RewriteRule ^/(.*) /%1/public%{REQUEST_FILENAME} [L]

    RewriteCond %{SERVER_NAME} ^dev.([^.]+).com$
    RewriteCond %{DOCUMENT_ROOT}/%1/public -d
    RewriteCond %{DOCUMENT_ROOT}/%1/public%{REQUEST_FILENAME} !-d
    RewriteCond %{DOCUMENT_ROOT}/%1/public%{REQUEST_FILENAME} !-f
    RewriteRule ^/(.*) /%1/public/index.php [L]
    # End public

    # Add more paths here if you want :)

    # Default
    RewriteCond %{SERVER_NAME} ^dev.([^.]+).com$
    RewriteCond %{DOCUMENT_ROOT}/%1/%{REQUEST_FILENAME} !-f
    RewriteRule ^/(.*) /%1/index.php [L]

</VirtualHost>
# End added by xXLXx" >> $vhostsFile
fi

sudo sh $installdir/stopApache.sh
sudo sh $installdir/startApache.sh

# Apply the automator to watch over the files
chmod +x ./addDynamicHosts.sh
cp ./addDynamicHosts.sh $installdir

sudo cp ./com.xXLXx.dynamic-vhost.plist $daemonsPath
sudo launchctl load -w $daemonsPath/com.xXLXx.dynamic-vhost.plist
sudo launchctl start -w $daemonsPath/com.xXLXx.dynamic-vhost.plist