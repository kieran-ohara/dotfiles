# curl --
{:data-section="shell"}
{:data-date="November 23, 2018"}
{:data-extra="Um Pages"}

## SYNOPSIS


## DESCRIPTION


## OPTIONS

 -E, --cert <certificate[:password]>
              (TLS) Tells curl to use the specified  client  certificate  file
              col. The certificate must be in PKCS#12 format if  using  Secure
              terminal.  Note  that  this  option assumes a "certificate" file
              that is the private key and the client certificate concatenated!
              can tell curl the nickname of the certificate to use within  the
              then the certificate string can either be the name of a certifi-
              a PKCS#12-encoded certificate and private key. If  you  want  to
              name/port that is used for TLS/SSL (e.g. SNI, certificate  veri-
              tion List that may specify peer certificates that are to be con-
              Transport  server  over  FTPS  using a client certificate, using
              the certificate.
              certificate contains the right name  and  verifies  successfully
              using the cert store.
               https://curl.haxx.se/docs/sslcerts.html
              certificate indicating its identity. A public key  is  extracted
              from  this certificate and if it does not exactly match the pub-


--key <key>
              (TLS SSH) Private key file name. Allows you to provide your pri-
              vate key in this separate file. For SSH, if not specified,  curl
              (SSH TLS) Passphrase for the private key
