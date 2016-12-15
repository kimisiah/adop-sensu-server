#FROM sstarcher/sensu 
FROM accenture/adop-sensu:0.1.0
#FROM sstarcher/sensu:0.26.5

# Enable Embedded Ruby
RUN sed -i -r 's/EMBEDDED_RUBY=false/EMBEDDED_RUBY=true/' /etc/default/sensu

# Install Mailer 2.5.4
RUN /opt/sensu/embedded/bin/gem install mail --version 2.5.4
RUN /opt/sensu/embedded/bin/gem install aws-ses
RUN /opt/sensu/embedded/bin/gem uninstall sensu-plugins-mailer --version 0.1.2
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-mailer

# Bake config & checks in
COPY resources/conf.d/* /etc/sensu/conf.d/
COPY resources/check.d/ /etc/sensu/check.d/
COPY resources/handlers/* /etc/sensu/handlers/
COPY resources/plugins /etc/sensu/plugins/
RUN chmod -R +x /etc/sensu/plugins
