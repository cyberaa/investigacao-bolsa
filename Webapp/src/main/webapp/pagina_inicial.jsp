<%@ page language="java" contentType="text/html; charset=utf8"
         pageEncoding="utf8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
    <link href="bootstrap-3.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!--<link href="simplex/bootstrap.min.css" rel="stylesheet">-->
    <title>Purificador de Séries Temporais</title>
    <script type="text/javascript" src="js/jquery.js"></script>
    <style>
        .btn-file {
            position: relative;
            overflow: hidden;
        }
        .btn-file input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            min-width: 100%;
            min-height: 100%;
            font-size: 999px;
            text-align: right;
            filter: alpha(opacity=0);
            opacity: 0;
            background: red;
            cursor: inherit;
            display: block;
        }
        input[readonly] {
            background-color: white !important;
            cursor: text !important;
        }
    </style>
    <script>

        function doSubmitFile() {

        }

        function doApplyMethod() {

        }

        function onAccommodationSuccess(data) {
            var btn = $('#submit_method_button');
            btn.text('OK!');
            btn.addClass('btn-success').removeClass('btn-primary').removeClass('btn-danger');

            $('#result_panel').show();
            var image = $('#output_image');
            image.attr('src',data.resultingImagePNG);

            if ( $('#preprocessData').prop('checked') ) {
                var link = $('#output_file');
                link.attr('href',data.resultingOutputFilePath);
            }
        }

        function onAccommodationFailure(data) {
            var btn = $('#submit_method_button');
            btn.text('Error applying method');
            btn.addClass('btn-danger').removeClass('btn-primary').removeClass('btn-success');
        }

        function isValidPositiveNum(input) {
            return !isNaN(input) && parseFloat(input) > 0;
        }

        function isValidPositiveInt(input) {
            return !isNaN(input) && parseInt(input) > 0;
        }

        function onSubmitFileSuccess(data) {
            var button =$('#submit_button');
            button.addClass('btn-success').removeClass('btn-info').removeClass('btn-danger');
            button.text('Valid File');
            $('#method_selection_panel').show();
            var getfilebtn=$('#output_pre_processed_file');
            getfilebtn.show();
            getfilebtn.attr('href', data.outputFilePath);
        }

        function onSubmitFileFailure(data) {
            var button =$('#submit_button');
            button.addClass('btn-danger').removeClass('btn-info');
            button.text(data.errorMsg);
        }

        function detectionMethodSelected() {
            var argument_box = $('#method_argument_box'); argument_box.show();
            var method_argument_text_box = $('#method_argument');
            var m = $('#method').val();
            var method_argument_recommendations_box = $('#method_argument_value');
            var argument_name, argument_recommendations;

            if ( m == "4" ) {
                argument_name='Z-Score Threshold: ';
                argument_recommendations='Recommended: 3.5';
            } else if ( m == "5") {
                argument_name='MADe Coefficient: ';
                argument_recommendations='Recommended: 2.3, 1.483';
            } else if ( m == "3" ) {
                argument_name='Confidence: ';
                argument_recommendations='Recommended: 0.05, 0.25';
            } else if ( m == "0" || m == "1" ) {
                argument_name='Standard Normal Deviation: ';
                argument_recommendations='Recommended: 2, 2.5, 3'
            } else if ( m == "2" ) {
                argument_name='Interquartile Range Multiplier: ';
                argument_recommendations='Recommended: 2.31'
            }

            method_argument_text_box.text(argument_name);
            method_argument_recommendations_box.attr("placeholder", argument_recommendations);
            revalidateMethodInput();
        }

        function preprocessingAreaChanged() {
            var fillMissingValues = $('#fillInMissingValues').prop('checked');
            var resample = $('#resampleEnabled').prop('checked');
            var ts = $('#resample_period').val();
            var missingValuesMethodsArea = $('#missingValueFillingArea');
            var resamplingArea = $('#resamplingArea');
            var preprocessData = $('#preprocessData').prop('checked');
            var proprocessingArea = $('#preprocessing_area');
            var outputFileBtn = $('#output_pre_processed_file');

            outputFileBtn.hide();
            $('#method_selection_panel').hide();
            $('#result_panel').hide();
            if ( preprocessData ) {
                proprocessingArea.show();
            } else {
                proprocessingArea.hide();
            }

            if ( fillMissingValues ) {
                missingValuesMethodsArea.show();
            } else {
                missingValuesMethodsArea.hide();
            }

            if ( resample ) {
                resamplingArea.show();
            } else {
                resamplingArea.hide();
            }

            if ( preprocessData && resample && !isValidPositiveNum(ts)) {
                var button =$('#submit_button');
                button.addClass('btn-warning').removeClass('btn-info').removeClass('btn-danger').removeClass('btn-success');
                button.prop('disabled',true);
                button.text('Invalid Parameters');
            } else {
                if( gLastSelectedFile.length ) {
                    var button =$('#submit_button');
                    button.prop('disabled',false);
                    button.addClass('btn-info').removeClass('btn-warning').removeClass('btn-danger').removeClass('btn-success');
                    button.text('Ready to Submit');
                } else {
                    var button =$('#submit_button');
                    button.addClass('btn-warning').removeClass('btn-info').removeClass('btn-danger').removeClass('btn-success');
                    button.prop('disabled',true);
                    button.text('No file selected');
                }
            }
        }

        function revalidateMethodInput() {
            var slidingWindow = $('#useSlidingWindow').prop('checked');
            var v = $('#method_argument_value');
            var value = v.val();
            var overlapBox = $('#window_overlap_box');
            var window_overlap_val = $('#window_overlap').val();
            var window_size_val = $('#window_size').val();
            var btn = $('#submit_method_button');
            btn.text('Apply Method');
            btn.addClass('btn-primary').removeClass('btn-success').removeClass('btn-danger');
            $('#result_panel').hide();
            if ( slidingWindow ) {
                overlapBox.hide();
            } else {
                overlapBox.show();
            }

            //TODO: make sure window_overlap_val < window_size_val

        //FIXME: Assuming value is valid
        if ( value == "" || window_size_val == "" ||
                !isValidPositiveNum(value) ||
                !isValidPositiveInt(window_size_val) ||
                (!slidingWindow && (!isValidPositiveInt(window_overlap_val) || window_overlap_val == ""
                        || window_size_val <= window_overlap_val))
                 ) {
            btn.prop('disabled',true);
        } else {
            btn.prop('disabled',false);
        }
    }
    </script>
    <script>
        gLastSelectedFile="";
        $(document)
                .on('change', '.btn-file :file', function() {
                    $('#method_selection_panel').hide();
                    $('#result_panel').hide();
                    var input = $(this),
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [label]);
                });

        $(document).ready(function() {
            $('#submit_button').prop('disabled',true);
            $('#useSlidingWindow').prop('checked', true);
            detectionMethodSelected();
            preprocessingAreaChanged();
            $("form#method_selection").submit(function(){

                var formData = new FormData($(this)[0]);
                var button =$('#submit_method_button');
                //FIXME: Show we're processing here
                button.prop('disabled',true);
                button.text('Processing request...');
                $.ajax({
                    url: 'acommodation.action',
                    type: 'POST',
                    data: formData,
                    beforeSend: function (xhr){
                        xhr.setRequestHeader("Accept","text/json");
                    },
                    async: true,
                    success: function (data) {
                        if ( data.success ) {
                            onAccommodationSuccess(data);
                        } else {
                            console.log(data);
                            onAccommodationFailure(data);
                        }

                    },
                    cache: false,
                    contentType: false,
                    processData: false
                });

                return false;
            });
            $("form#inputfiledata").submit(function(){

                var formData = new FormData( $(this)[0]);
                var button =$('#submit_button');
                button.text('Processing request...');
                button.prop('disabled',true);
                $.ajax({
                    url: 'submitfile.action',
                    type: 'POST',
                    data: formData,
                    beforeSend: function (xhr){
                        xhr.setRequestHeader("Accept","text/json");
                    },
                    async: true,
                    success: function (data) {
                        if ( data.success ) {
                            onSubmitFileSuccess(data);
                        } else {
                            console.log(data);
                            onSubmitFileFailure(data);
                        }

                    },
                    cache: false,
                    contentType: false,
                    processData: false
                });

                return false;
            });
            $('#method_selection_panel').hide();
            $('#result_panel').hide();
            $('.btn-file :file').on('fileselect', function(event, label) {
                gLastSelectedFile = label;
                $('#method_selection_panel').hide();
                $('#result_panel').hide();
                var input = $(this).parents('.input-group').find(':text'),
                        log = label;

                input.val(log);
                preprocessingAreaChanged();
            });
        });
    </script>
</head>
<body>
<div class="jumbotron">
    <div class="container">
        <h1 style="text-align: center">Time series outlier detection and accommodation</h1>
    </div>
</div>

<div class="col-sm-8 col-md-offset-2" id="methods_area" >
    <div class="panel panel-success" style="text-align: center">
        <div class="panel-heading">Input file selection & Pre-processing</div>
        <div class="panel-body">
            <form id="inputfiledata" method="post" enctype="multipart/form-data" action="submitfile.action">
                <h2>Select an input file</h2>
                <p>Valid formats: .csv, .xls, .xlsx, with two rows or columns (time and data)</p>
                <p>If you choose the pre-process the data, you can download the pre-processed file, which will be
                   used when applying the methods</p>
                <div class="input-group">

                    <input type="checkbox"  name="preprocessData" id="preprocessData" value="true"
                           onchange="preprocessingAreaChanged()">
                    &nbsp; Pre-Process the data
                    </input>
                </div>
                <div id="preprocessing_area" style="padding-left:50px;">
                <div class="input-group">

                    <input type="checkbox"  name="fillInMissingValues" id="fillInMissingValues" value="true"
                           onchange="preprocessingAreaChanged()">
                    &nbsp; Fill in Missing values
                    </input>
                </div>
                <div class="input-group" style="padding-left:50px;" id="missingValueFillingArea">
                    <br />
                    <span class="input-group-addon">Missing Value Replacement Method:</span>
                    <select class="form-control" id="missingValueFillingMethod" name="missingValueFillingMethod">
                        <option value="linear">Linear</option>
                        <option value="zoh">Zero-Order Hold</option>
                    </select>
                </div><br />
                <div class="input-group">
                    <input type="checkbox" name="resampleEnabled" id="resampleEnabled" value="true"
                           onchange="preprocessingAreaChanged()">
                    &nbsp; Resample data
                    </input>
                </div>
                <div class="input-group" style="padding-left:50px;"  id="resamplingArea"><br />
                    <span class="input-group-addon">Resampling period:</span>
                    <input type="text" class="form-control" placeholder="Value"
                           id="resample_period" name="resamplePeriod"
                           onkeyup="preprocessingAreaChanged()">
                </div></div>
                    <br />
                <div class="input-group">
                    <div class="input-group">
                        <span class="input-group-btn">
                            <span class="btn btn-primary btn-file">
                                Select Input File... <input type="file" name="file">
                            </span>
                        </span>
                        <input type="text" class="form-control" readonly=""
                               value="No file selected" style="width:250px;" name="filename"> &nbsp;
                        <button id="submit_button" class="btn btn-warning btn-lg" onclick="doSubmitFile()">No file
                            selected</button>
                        <button type="submit" id="submitIt" style="display:none"></button>&nbsp;
                        <a href="#" type="button" class="btn btn-primary btn-lg" id="output_pre_processed_file">
                            Get Pre-Processed File</a>
                    </div>

                </div>
            </form>
        </div>
    </div>
    <div class="panel panel-success" style="text-align:center" id="method_selection_panel">
        <div class="panel-heading">Method selection</div>
        <div class="panel-body">
            <form id="method_selection" method="post" enctype="multipart/form-data" action="accommodate.action"
                  role="form" >
                <h2 >Select Outlier Detection and Accommodation methods</h2>
                <p>The data from the previous section is used (if you have pre-processed data,
                    it is used instead of the raw supplied data)</p>
                <div class="input-group">
                    <span class="input-group-addon">Outlier Detection Method: </span>
                    <select onchange="detectionMethodSelected()" class="form-control" name="method" id="method">
                        <option value="4">Modified Z-Score</option>
                        <option value="5">MAD Test</option>
                        <option value="3">Grubb's Test</option>
                        <option value="0">SND Method</option>
                        <option value="1">Linear Method</option>
                        <option value="2">IQR Method</option>
                    </select>
                </div><br />
                <div class="input-group">
                    <span class="input-group-addon">Accommodation Method:</span>
                    <select class="form-control" name="accommodationMethod">
                        <option value="1">Linear</option>
                        <option value="0">Mean</option>
                    </select>
                </div><br />
                <div class="input-group" id="method_argument_box" style="display:none;">
                    <div class="input-group">
                        <span class="input-group-addon" id="method_argument">Argument:</span>
                        <input type="text" class="form-control" placeholder="Value"
                               id="method_argument_value" style="min-width:275px;"
                               name="methodArgument" onkeyup="revalidateMethodInput()">
                    </div><br />
                </div>
                <div class="input-group" id="window_size_box">
                    <div class="input-group">
                        <span class="input-group-addon">Window Size:</span>
                        <input type="text" class="form-control" placeholder="Value"
                               id="window_size" name="windowSize" style="min-width:275px;"
                               onkeyup="revalidateMethodInput()">
                    </div><br />
                </div>
                <div class="input-group">
                    <input type="checkbox" name="useSlidingWindow" id="useSlidingWindow" value="true"
                           onchange="revalidateMethodInput()">
                        &nbsp; Sliding Window
                    </input>
                </div><br />
                <div class="input-group" id="window_overlap_box">
                    <div class="input-group">
                        <span class="input-group-addon">Window Overlap:</span>
                        <input type="text" class="form-control" placeholder="Value"
                               id="window_overlap" name="windowOverlap" style="min-width:275px;"
                               onkeyup="revalidateMethodInput()">
                    </div><br />
                </div>
                <button id="submit_method_button" class="btn btn-primary btn-lg" onclick="doApplyMethod()">
                    Apply Method
                </button>
                <button type="submit" id="submitIt2" style="display:none"></button>

            </form>
        </div>
    </div>

    <div class="panel panel-success" style="text-align:center" id="result_panel" style="display:none">
        <div class="panel-heading"><h2>Results</h2></div>
        <div class="panel-body">
            <h2>Resulting Plot</h2>
            <img src="" id="output_image">
            <h2>Resulting File</h2>
            <a href="#" type="button" class="btn btn-success" id="output_file">Get File</a>
        </div>
    </div>

</div>


<script src="bootstrap-3.0.2/dist/js/bootstrap.min.js"></script>
</body>
</html>