DANF                PLFORM            DANFORM.PLF
Text1               dim               1000
sapi                automation
SapiSpeech          automation

                    create             SapiSpeech,Class="SAPI.SpInprocRecognizer"

                    create            sapi,class="Sapi.SpVoice"
                    FORMLOAD          DANF
                    LOOP
                      WAITEVENT
                    REPEAT
                    STOP
SPEAKIT             getitem           Etext1,0,text1
                    sapi.Speak        using Text1
                    RETURN
dispui              sapi.DisplayUI
                    RETURN


