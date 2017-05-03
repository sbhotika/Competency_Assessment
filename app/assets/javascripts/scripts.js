/*
 * ============================================================================
 * General Scripts
 * ============================================================================
 */

var tab_load_count = 0;
// Contains all set up functions, mainly for materialize
(function($){
  $(function(){

    $(".button-collapse").sideNav({
      edge: "right"
    });
    $(".parallax").parallax();
    $(".scrollspy").scrollSpy({
      scrollOffset: 100
    });
    $(".modal").modal();
    $("ul.tabs").tabs({
      onShow: function(tab) {
        if(tab_load_count == 0) {
          $(".carousel").carousel();
          tab_load_count++;
        }
      }
    });
  }); // end of document ready
})(jQuery); // end of jQuery name space

// Autogenerate the copyright text
$(function(){
  var year = new Date().getFullYear();
  var copyright = "© " + year + " Carnegie Mellon University";
  $("footer #copyright").html(copyright);
});

// Set up event listeners for the flash and error messages
$(function(){
  $("#alert-close").click(function(){
    $( "#alert-box" ).fadeOut( "slow", function() {
    });
  });
});

// Used to make sure that all cards are of the same height
function standardizeCardSize(element) {
  var maxHeight = -1;
  $(element + " .card").each(function() {
    maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
  });

  $(element + " .card").each(function() {
    $(this).height(maxHeight);
  });
}

/*
 * ============================================================================
 * Collection_select Code
 * ============================================================================
 */

$(document).ready(function() {
 $('select').material_select();
});


/*
 * ============================================================================
 * Assessment Report Code
 * ============================================================================
 */

// The initial set of colors for each level
var colors = ["#a60", "#247", "#085"];
var level_colors = {};

// Helper method to get a random color
function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

// Initialize the level colors for the report
function initColors(levels) {
  // Generate the list of colors needed for each level
  if(levels.length <= colors.length){
    colors = _.slice(colors, 0, levels.length);
  } else {
    for(var i = colors.length; i < levels.length; i++){
      colors.push(getRandomColor());
    }
  }
  // Create a hash of level name to color mapping
  for(var i = 0; i < levels.length; i++){
    var name = levels[i].name;
    level_colors[name] = colors[i];
  }
}

// Create chart that displays indicators by stage by level.
function createLevelsChart(indicators_resources, levels, competency) {
  var id = "levels-chart";
  // The categories are the list of capitalized stages
  // ex) [Developed, Developing, Emerging]
  var categories = _.keys(indicators_resources).map(function(stage){
    return _.capitalize(stage);
  });

  // Get list of counts of indicators per level by stage
  // ex) [{Champion: 9, Contributor: 1, Companion: 2}, {Champion: 2, Contributor: 1, Companion: 7}]
  var indicators_by_stage_level = _.map(indicators_resources, function(indicators){
    return _.countBy(indicators, "level.name");
  });

  // Parse the data from the the indicator count by level
  // [{name: Champion, data: [9, 2]}, {name: Contributor, data: [1, 1]}, {name: Companion, data: [2, 7]}]
  var data = _.map(levels, function(level){
    var level_name = level.name;
    // Gets the list of indicator counts for each stage (return 0 if its undefined)
    var level_data = _.map(indicators_by_stage_level, function(count) {
      return count[level_name] ? count[level_name] : 0;
    });
    return {
      name: level_name,
      data: level_data
    }
  });

  createChart(id, "column", "", "Stages", "Indicators", categories, data);
}

// Creates a generic chart with specified type and other fields
function createChart(container_id, type, title, x_title, y_title, categories, data) {
  Highcharts.chart(container_id, {
    chart: {
      type: type
    },
    title: {
      text: title
    },
    xAxis: {
      categories: categories,
      title: {
          text: x_title
      }
    },
    yAxis: {
      min: 0,
      title: {
          text: y_title
      },
      stackLabels: {
          enabled: true,
          style: {
              fontWeight: 'bold',
              color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
          }
      }
    },
    legend: {
      align: 'right',
      x: -30,
      verticalAlign: 'top',
      y: 25,
      floating: true,
      backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
      borderColor: '#CCC',
      borderWidth: 1,
      shadow: false
    },
    colors: colors,
    tooltip: {
      headerFormat: '<b>{point.x}</b><br/>',
      pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
    },
    plotOptions: {
      column: {
          stacking: 'normal',
          dataLabels: {
              enabled: true,
              color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
          }
      }
    },
    series: data
  });
}

// Set the icon colors to the corresponding level colors in the report
function setLevelColor() {
  var icons = $(".level-icon");
  for(var i = 0; i < icons.length; i++) {
    var icon = $(icons[i]);
    var level = icon.data("level");
    icon.css("color", level_colors[level]);
  }

  var descriptions = $("#level-descriptions .card");
  for(var i = 0; i < descriptions.length; i++) {
    var descript = $(descriptions[i]);
    var level = descript.data("level");
    descript.css("background-color", level_colors[level]);
  }
}

/*
 * ============================================================================
 * Assessments Code
 * ============================================================================
 */


// Global variables for the assessment
var question_number = 0;
var num_questions = 0;

// First used to initialize the assessment
// Sets the total number of questions and shows the first question
function initAssessment(num_q){
  num_questions = num_q;
  $("#question-0").show()
  updateAssessment();
}

// Called when the next question button is clicked
// Checks that the current question is answered and if so
// increase the current question number variable by 1.
function nextQuestion() {
  if(hasCheckedRadio(question_number)) {
    $("#question-" + question_number).hide();
    question_number++;
    $("#question-" + question_number).show();
    updateAssessment();
  } else {
    displayError("This question is required to continue.");
  }
}

// Called when the next question button is clicked
// Decreases the current question number variable by 1.
function previousQuestion() {
  $("#question-" + question_number).hide();
  question_number--;
  $("#question-" + question_number).show();
  updateAssessment();
}

// Function that updates all aspects of the assessment for each action
function updateAssessment() {
  buttonUpdate();
  updateProgress();
}

// Updates the the buttons (next, previous, finish) based on question number
function buttonUpdate() {
  if(question_number == num_questions - 1) {
    $("#assessment-submit").show();
    $("#assessment-prev").prop('disabled', false);
    $("#assessment-next").prop('disabled', true);;
  } else if(question_number == 0){
    $("#assessment-submit").hide();
    $("#assessment-prev").prop('disabled', true);;
    $("#assessment-next").prop('disabled', false);
  } else {
    $("#assessment-submit").hide();
    $("#assessment-prev").prop('disabled', false);
    $("#assessment-next").prop('disabled', false);
  }
}

// Updates the progress bar based on question number
function updateProgress() {
  var elem = $("#assessment-bar")[0];
  var current_question_number = question_number + 1;
  var percentage = (current_question_number / num_questions) * 100;
  elem.style.width = percentage + "%";
  elem.innerHTML = current_question_number + " of " + num_questions;
}

// Called before submitting the assessment and
// checks if the assessment is valid and if all questions are answered.
function validAssessment() {
  for(var i = 0; i < num_questions; i++) {
    if(!hasCheckedRadio(i)) {
      displayError("This question is required to submit.");
      return false;
    }
  }
  return true;
}

// Helper function to display the assessment error
function displayError(msg) {
  Materialize.toast(msg, 4000, "error bottom");
}

// Function that checks if a question is answered or not
function hasCheckedRadio(q_num) {
  return $("#question-" + q_num + " input[type=radio]:checked").length > 0;
}

// For the discailmer, checks if the I Agree checkbox is checked and
// disable/enable the continue button accordingly.
function iAgree(){
  $("#disclaimer-submit")[0].disabled = !$("#accept")[0].checked;
}

/*
 * ============================================================================
 * Datatables Code
 * ============================================================================
 */

 $(document).ready(function() {
     $('table.display').dataTable({"sPaginationType": "full_numbers", "iDisplayLength" : 10, ordering: true});
 });
