IMPORT util
IMPORT os
TYPE mailRec RECORD
  app STRING,
  subject STRING,
  body STRING,
  to DYNAMIC ARRAY OF STRING,
  cc DYNAMIC ARRAY OF STRING,
  bcc DYNAMIC ARRAY OF STRING,
  attachments DYNAMIC ARRAY OF STRING,
  isHtml BOOLEAN,
  chooserHeader STRING
END RECORD
DEFINE mail mailRec
MAIN
  LET mail.app="mailto"
  LET mail.subject="A mail with Html body and pdf attachment"
  CALL util.JSON.parse('["huhu@haha.com"]',mail.to)
  LET mail.body="<h1>Nice greetings from Erfurt</h1>"
  LET mail.isHtml=TRUE
  LET mail.chooserHeader="Open With"
  LET mail.attachments[1]="file://",os.Path.join(os.Path.dirname(arg_val(0)),"hello.pdf")
  MENU "Mail Test"
    COMMAND "Compose Mail"
      CALL open(mail.*)
    COMMAND "Exit"
      EXIT MENU
  END MENU
END MAIN

FUNCTION open(m mailRec)
  DEFINE result STRING
  TRY
    CALL ui.Interface.frontCall("cordova","call",
                             ["EmailComposer","open",m],[result])
    MESSAGE result
  CATCH
    ERROR err_get(status)
  END TRY
END FUNCTION
