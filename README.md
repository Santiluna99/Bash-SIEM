# Instalar Postfix

1.
$ sudo apt install postfix libsasl2-modules

2.
$ sudo dpkg-reconfigure postfix

No configuration: Should be chosen to leave the current configuration unchanged.

Internet site: Mail is sent and received directly using SMTP.

Internet with smarthost: Mail is received directly using SMTP or by running a utility such as fetchmail. Outgoing mail is sent using a smart host.

Satellite system: All mail is sent to another machine, called a 'smarthost', for delivery.

Local only: The only delivered mail is the mail for local users. There is no network.

2.1.
Internet site

2.2.
smtp.domain.local

2.3.
Mail for the 'postmaster', 'root', and other system accounts needs to be redirected to the user account of the actual system administrator.

If this value is left empty, such mail will be saved in /var/mail/nobody, which is not recommended.

[...]

2.4.
root@domain.local...
Please give a common-separated list of domains for which this machine should consider itself the final destination. If this is a mail domain gateway, you probably want to include the top-level domain.

Other destinations to accept mail for (blank for none):

2.5.
No
If synchronous updates are forced, then mail is processed more slowly. If not forced, then there is a remote chance of losing some mail if the system crashes at an inopportune time, and you are not using a journaled filesystem (such as ext3).
 
2.6.
127.0.0.0/8 ...
Please specify the network blocks for which this host should relay mail. The default is just the local host...

2.7.
25000000 (25MB)
Please specify the limit that Postfix should place on mailbox files to prevent runway software errors. A value of zero (0) means no limit. The upstream default is 51200000.

2.8.
+
Please choose the character that will be used to define a local address extension.

To not use address extensions, leave the string blank.

2.9.
all (use both IPv4 and IPv6 addresses)
By default, whichever Internet protocols are enabled on the system at installation time will be used. ...

3.
$ sudo vim /etc/postfix/main.cf

myhostname = smtp.domain.hk

relayhost = [smtp.gmail.com]:587

#Enable SASL authentication

smtp_sasl_auth_enable = yes

#Disallow methods that allow anonymous authentication

smtp_sasl_security_options = noanonymous

#Location of sasl_passwd

smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd

#Enable STARTTLS encryption

smtp_tls_security_level = encrypt

#Location of CA certificates

smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt

4.
$ sudo vim /etc/postfix/sasl/sasl_passwd

[smtp.gmail.com]:587 username@gmail.com:{APP PASSWORD}

5. Enable “Less secure apps” access: https://www.google.com/settings/security/lesssecureapps
  
6.
$ sudo postmap /etc/postfix/sasl/sasl_passwd
 
7.
$ sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db

$ sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db

8. Limit what IPs can use the SMTP service.
$ sudo vim /etc/postfix/main.cf

mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 192.168.1.2 192.168.1.3

9. For vCenter:
$ sudo vim /etc/mail/sendmail.mc

FEATURE(`nocanonify`)

If not, get:
$ sudo tail -f /var/log/syslog
2020-11-30T04:23:31.117593+00:00 vcenter sendmail[63191]: 0AU4NVat063189: to=<adm.vms@domain.hk>, delay=00:00:00, xdelay=00:00:00, mailer=relay, pri=120870, relay=192.168.1.2, dsn=5.1.2, stat=Host unknown (Name server: 192.168.1.2: host not found)
2020-11-30T04:23:31.118176+00:00 vcenter sendmail[63191]: 0AU4NVat063189: 0AU4NVas063191: DSN: Host unknown (Name server: 192.168.1.2: host not found)
  
10.
$ sudo systemctl restart postfix

12.
$ sudo ufw allow Postfix

$ sudo ufw status

# Instalar mailutils
## Referencia: https://www.youtube.com/watch?v=iBgNohv2oJM

### 1 
sudo apt install mailutils -y

### 2
sudo apt install dovecot-core dovecot-imapd dovecot-pop3d -y

### 3

ir al archivo etc/dovecot/dovecot.conf > descomentar linea que dice *listen=**

### 4

ir al archivo etc/dovecot/conf.d/10-auth.conf > colocar no en la linea disable_plaintext_auth > agregar una linea de codigo auth_mechanism = plain login > comentar linea de unix listener > descomentar la otra linea de unix listener

### 5

service postfix restart

### 6

service postfix restart

### 7

En el archivo etc/postfix/main.cf comentar la linea de relayhost y agregar lo siguiente

![image](https://github.com/Santiluna99/SIEM-BASH/assets/92774109/64969605-b471-4149-a289-3943d1d9b381)


### 8

Crear archivo etc/postfix/sasl_passwd y agregar

![(8) Instalacion y configuracion del Postfix y Mailutils en Linux - YouTube - Brave 07_03_2024 12_23_44 a  m](https://github.com/Santiluna99/SIEM-BASH/assets/92774109/d6d2bf8f-9d09-4d76-bb60-d96d0cfdfb71)

(Cambiar por mail que hayamos puesto) (Passw opcional)

# Crear Bot de telegram

## Referencia https://www.youtube.com/watch?v=Qg5BaKTW1Uw
## Referencia https://linuxscriptshub.com/send-telegram-message-linux-scripts/


