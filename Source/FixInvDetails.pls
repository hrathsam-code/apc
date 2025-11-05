;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixinvdetails                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    10/14/2019 at 1:04pm                                           ;
;                                                                             ;
;  purpose:    Used to reformat the InvDetails file                           ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   10/14/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;


                   include           WorkVar.inc
                   include           Parts.FD
                   include           cust.fd
                   include           OrderDetails.fd

                   include           InvDetails.FD
                   include           InvDetails.FDold

NewInvDetails      file
InputFile          file

                   prep              NewInvDetails,"InvDetails.Octnew",exclusive
                   open              InputFile,"InvDetails.txt",READ

                   loop
                     read              InputFile,seq;InvDetailsOLD
                   until (over)

                    move              InvDetailsOLD.Entity,InvDetails.Entity
                    move              InvDetailsOLD.Reference,InvDetails.Reference
                    move              InvDetailsOLD.OrderNumber,InvDetails.OrderNumber
                    move              InvDetailsOLD.TicketNumber,InvDetails.TicketNumber
                    move              InvDetailsOLD.SeqMajor,InvDetails.SeqMajor
                    move              InvDetailsOLD.SeqMinor,InvDetails.SeqMinor
                    move              InvDetailsOLD.LineNo,InvDetails.LineNo
                    move              InvDetailsOLD.PartNumber,InvDetails.PartNumber
                    move              InvDetailsOLD.EntryDate,InvDetails.EntryDate
                    move              InvDetailsOLD.TransDate,InvDetails.TransDate
                    move              InvDetailsOLD.BillDate,InvDetails.BillDate
                    move              InvDetailsOLD.ShipDate,InvDetails.ShipDate
                    move              InvDetailsOLD.Freight,InvDetails.Freight
                    move              InvDetailsOLD.InvoiceAmt,InvDetails.InvoiceAmt
                    move              InvDetailsOLD.TaxableAmt,InvDetails.TaxableAmt
                    move              InvDetailsOLD.SalesAmt,InvDetails.SalesAmt
                    move              InvDetailsOLD.FuelAmt,InvDetails.FuelAmt
                    move              InvDetailsOLD.OtherAmt,InvDetails.OtherAmt
                    move              InvDetailsOLD.DiscountAmt,InvDetails.DiscountAmt
                    move              InvDetailsOLD.OrderQty,InvDetails.OrderQty
                    move              InvDetailsOLD.ShipQty,InvDetails.ShipQty
                    move              InvDetailsOLD.BackOrderQty,InvDetails.BackOrderQty
                    move              InvDetailsOLD.BillCust,InvDetails.BillCust
                    move              InvDetailsOLD.ShipToCust,InvDetails.ShipToCust
                    move              InvDetailsOLD.UOM,InvDetails.UOM
                    move              InvDetailsOLD.UnitPrice,InvDetails.UnitPrice
                    move              InvDetailsOLD.ExtraCharges,InvDetails.ExtraCharges
                    move              InvDetailsOLD.ExtendedAmt,InvDetails.ExtendedAmt
                    move              InvDetailsOLD.Description1,InvDetails.Description1
                    move              InvDetailsOLD.Description2,InvDetails.Description2
                    move              InvDetailsOLD.TaxCode,InvDetails.TaxCode
                    move              InvDetailsOLD.ReplacementPartNumber,InvDetails.ReplacementPartNumber
                    move              InvDetailsOLD.SerialNumbered,InvDetails.SerialNumbered
                    move              InvDetailsOLD.WarrantyIncluded,InvDetails.WarrantyIncluded
                    move              InvDetailsOLD.WarrantyTime,InvDetails.WarrantyTime
                    move              InvDetailsOLD.ServiceLife,InvDetails.ServiceLife
                    move              InvDetailsOLD.Cost,InvDetails.Cost
                    move              InvDetailsOLD.KitItem,InvDetails.KitItem
                    move              InvDetailsOLD.Size,InvDetails.Size
                    move              InvDetailsOLD.LotNumber,InvDetails.LotNumber
                    move              InvDetailsOLD.ItemType,InvDetails.ItemType
                    move              InvDetailsOLD.AllowFractional,InvDetails.AllowFractional
                    write             NewInvDetails,seq;InvDetails
                   repeat

