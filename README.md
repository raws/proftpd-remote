### protftpd-remote

A simple Sinatra web app that can create and delete users in a [ProFTPD](http://www.proftpd.org) server configuration.

### Deployment

In order to run the app, these environment variables must be set:

| Name | Description |
|------|-------------|
| `PROFTPD_FTPASSWD` | Path to ProFTPD's `ftpasswd` binary. |
| `PROFTPD_HOME` | Path to the user jail to set for new ProFTPD users. |
| `PROFTPD_USERS` | Path to ProFTPD's users file, specified by the [AuthUserFile](http://www.proftpd.org/docs/directives/linked/config_ref_AuthUserFile.html) directive. |
| `PROFTPD_GROUPS` | Path to ProFTPD's groups file, specified by the [AuthGroupFile](http://www.proftpd.org/docs/directives/linked/config_ref_AuthGroupFile.html) directive. |
| `RACK_ENV` | The app environment. |
