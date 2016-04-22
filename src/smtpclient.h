#pragma once
#ifndef SMTPCLIENT_H
#define SMTPCLIENT_H

#define SMTP_PORT 25
#define MAX_IDLE_COUNT 200 

#define STATE_UNDEFINED 0
#define STATE_EHLOSENT 1 
#define STATE_MAILFROMSENT 3 
#define STATE_RCPTTOSENT 7
#define STATE_SUCCESSFUL 15 

int SmtpCheckRcpt(char*, char*, char*, char*, int&);

#endif
