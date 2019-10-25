<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/components/core.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/components/md5.js"></script>
<link href="https://code.jquery.com/ui/1.10.4/themes/cupertino/jquery-ui.css" rel="stylesheet"/>
    <script>
        $(function () {

            


        })
        var closeChk = false;
        var startDate = '0';
        var endDate = '0';
        var someDate = new Date();
        var numberOfDaysToAdd = 0;
        var numberofmonths = sessionStorage.getItem("NumberOfMonths") == null ? 2 : sessionStorage.getItem("NumberOfMonths");
        numberOfDaysToAdd = sessionStorage.getItem('AdvancePurchase') == null ? 0 : sessionStorage.getItem('AdvancePurchase');
        someDate.setDate(someDate.getDate() + parseInt(numberOfDaysToAdd));
        var dpmode = '';
        $(function () {
            var sDates = [];
            $("#date-range0").datepicker({
                numberOfMonths: parseInt(numberofmonths),
                minDate: new Date(someDate),
                beforeShowDay: function (date) {
                    var selectable = true;
                    var classname = "dp-highlight";
                    var isHighlight = sDates[0] && ((date.getTime() == new Date(sDates[0]).getTime()) || (new Date(sDates[1]) && date >= new Date(sDates[0]) && date <= new Date(sDates[1])));
                    return [true, isHighlight ? "dp-highlight" : ""];
                },
                onSelect: function (selectedDate) {
                    dpmode = 'return';
                    if (!$(this).data().datepicker.first) {
                        $(this).data().datepicker.inline = true
                        $(this).data().datepicker.first = selectedDate;
                        if (closeChk) {
                            sDates = [];
                            closeChk = false;
                        }
                        startDate = selectedDate;
                        sDates.push(selectedDate);
                       // var date = ChangeDateFormat(selectedDate);
                        $("#txtOriginDate").val(startDate);
                    } else {
                        var fdate = new Date($(this).data().datepicker.first);
                        var sdate = new Date(selectedDate);
                        if (sdate > fdate) {
                            sDates.push(selectedDate);
                            $(this).val($(this).data().datepicker.first + " To " + selectedDate);
                            endDate = selectedDate;
                            $("#txtDestinationDate").val(endDate);
                        } else {
                            $(this).val(selectedDate + " - " + $(this).data().datepicker.first);
                            sDates.push($(this).data().datepicker.first);
                            startDate = selectedDate;
                            endDate = $(this).data().datepicker.first;
                            $("#txtOriginDate").val(startDate);
                            $("#txtDestinationDate").val(endDate);
                        }
                        $(this).data().datepicker.inline = false;
                       // var date = ChangeDateFormat(selectedDate);
                        
                    }
                },
                onClose: function () {
                    closeChk = true;
                    delete $(this).data().datepicker.first;
                    $(this).data().datepicker.inline = false;
                }
            })

             

             startDate = '11/01/2019';
             dpmode = 'depart';
             endDate = '11/30/2019';

            $('#ui-datepicker-div').delegate('.ui-datepicker-calendar td', 'mouseover', function () {


                if ($(this).data('year') == undefined) return;
                if (dpmode == 'depart' && endDate == '0') return;
                if (dpmode == 'return' && startDate == '0') return;

                if (dpmode == '') return;

                var currentDate = ($(this).data('month') + 1) + '/' + $('a', this).html() + '/' + $(this).data('year');
                currentDate = $.datepicker.parseDate("mm/dd/yy", currentDate).getTime();
                if (dpmode == 'depart') {
                    var StartDate = currentDate;
                    var EndDate = $.datepicker.parseDate("mm/dd/yy", endDate).getTime();
                }
                else {

                    var StartDate = $.datepicker.parseDate("mm/dd/yy", startDate).getTime();
                    var EndDate = currentDate;


                };
                $('#ui-datepicker-div td').each(function (index, el) {
                    if ($(this).data('year') == undefined) return;

                    var currentDate = ($(this).data('month') + 1) + '/' + $('a', this).html() + '/' + $(this).data('year');

                    currentDate = $.datepicker.parseDate("mm/dd/yy", currentDate).getTime();
                    if (currentDate >= StartDate && currentDate <= EndDate) {
                        $(this).addClass('dp-highlight')
                    } else {
                        $(this).removeClass('dp-highlight')
                    };
                });
            });
        });
        $(function () {
            var dates = {}
            $("#date-range1").datepicker({
                minDate: new Date(someDate),
                beforeShowDay: function (date) {
                    var dd = new Date(date)
                    var selectable = true;
                    var classname = "";
                    var dt = dates[dd];
                    var title = dates[dd];
                    if (dt) {
                        return [selectable, classname, title];
                    } else {
                        return [true, '', ''];
                    }
                },
                numberOfMonths: parseInt(numberofmonths)
            }).on('change', function () {
                var date = ChangeDateFormat($("#date-range1").val());
                $("#txtOriginDate").val(date);
            });
        });

        $(document).keydown(function (e) {
            if (e.keyCode == 37) {
                $(".ui-datepicker-prev").click();
            }
            if (e.keyCode == 39) {

                $(".ui-datepicker-next").click();
            }
        });

    </script>
    <style>
        

.dp-highlight .ui-state-default {
		background: #FAAE2A !important;
		color: #FFF;
	}
 
 
 
    </style>
    <script></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <input type="text" id="date-range0" />
        <br /><br /><br /><br /><br />
        <input type="text" id="txtOriginDate" />

        <input type="text" id="txtDestinationDate" />
    </div>
    </form>
</body>
</html>
