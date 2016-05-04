#ifndef SMTPCLIENT_H
#define SMTPCLIENT_H

#define SMTP_PORT 25
#define MAX_IDLE_COUNT 200 

#define STATE_UNDEFINED 0
#define STATE_EHLOSENT 1 
#define STATE_MAILFROMSENT 3 
#define STATE_RCPTTOSENT 7
#define STATE_SUCCESSFUL 15 

struct SMTP_AUTH_SET
{
  char ptr_domain[256];
  char mail_from[256];
  int sock_async_timeout;
};

int SmtpCheckRcpt(SMTP_AUTH_SET*, char*, char*);

#endif
