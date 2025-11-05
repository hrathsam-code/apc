;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixcreditcards                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/26/2019 at 11:16pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/26/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                   include           WorkVar.inc
                   include           Sequence.FD
                   include           CreditCards.FD

NewCreditCards                   RECORD
Entity                           Dim                8                   1 - 8
CustomerID                       dim                10                   // Like             Cust.CustomerID    //
SeqNo                            Like             Sequence.SeqNo    //
DateAdded                        Dim                8                  28 - 35
Primary                          Form               1                  36 - 36
Type                             Form               2                  37 - 38
Number                           Dim                20                 39 - 53
ExpirationDate                   Dim                8                  54 - 61
CVC                              Dim                8                  62 - 69
NameOnCard                       Dim                50                 70 - 119
NameOnCardFlag                   Form               1                 120 - 120
BillingAddressFlag               Form               1                 121 - 121
BillingAddressNo                 Dim                10                122 - 131
                                 RECORDEND

                   call             OpenCreditCards
OutputFile         file
                   prep              OutputFile,"CreditCards.new",Exclusive

                   move              "",CreditCardsKY
                   call              RDCreditCards
                   loop
                     call              KSCreditCards
                   until (ReturnFl=1)
                     move              CreditCards.Entity,NewCreditCards.Entity
                     move              CreditCards.CustomerID,NewCreditCards.CustomerID
                     move              CreditCards.SeqNo,NewCreditCards.SeqNo
                     move              CreditCards.DateAdded,NewCreditCards.DateAdded
                     move              CreditCards.Primary,NewCreditCards.Primary
                     move              CreditCards.Type,NewCreditCards.Type
                     move              CreditCards.Number,NewCreditCards.Number
                     move              CreditCards.ExpirationDate,NewCreditCards.ExpirationDate
                     move              CreditCards.CVC,NewCreditCards.CVC
                     move              CreditCards.NameOnCard,NewCreditCards.NameOnCard
                     move              CreditCards.NameOnCardFlag,NewCreditCards.NameOnCardFlag
                     move              CreditCards.BillingAddressFlag,NewCreditCards.BillingAddressFlag
                     move              CreditCards.BillingAddressNo,NewCreditCards.BillingAddressNo
                     write             OutputFile,Seq;NewCreditCards
                   repeat
